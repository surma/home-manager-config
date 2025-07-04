{
  pkgs,
  makeDesktopItem,
  symlinkJoin,
}:
{
  name,
  desktopName,
  platform ? "auto",
  package ? null,
  pkgName ? name,
  binName ? name,
}:
let
  orElse = def: v: if v != null then v else def;
  actualPackage = package |> orElse pkgs.${pkgName};
  desktopItem = makeDesktopItem {
    inherit name desktopName;
    exec = "${actualPackage}/bin/${binName} --ozone-platform=${platform}";
  };
in
symlinkJoin {
  inherit name;
  paths = [
    desktopItem
    actualPackage
  ];
}
