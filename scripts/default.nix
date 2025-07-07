{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  inherit (pkgs)
    nushell
    stdenv
    makeDesktopItem
    symlinkJoin
    ;

  src = ./.;
  scripts = builtins.readDir src |> lib.filterAttrs (name: _v: !lib.strings.hasSuffix ".nix" name);
in
{
  options = {
    customScripts =
      scripts
      |> lib.mapAttrs (
        name: _v: {
          enable = mkEnableOption "";
          asDesktopItem = mkEnableOption "";
        }
      );
  };
  config = {
    home.packages =
      scripts
      |> lib.attrsToList
      |> lib.filter ({ name, ... }: config.customScripts.${name}.enable)
      |> lib.map (
        { name, ... }:
        let
          script = stdenv.mkDerivation {
            name = "custom-script-${name}";
            src = "${src}/${name}";
            dontUnpack = true;
            buildInputs = [ nushell ];
            installPhase = ''
              mkdir -p $out/bin
              cp $src $out/bin
              patchShebangs $out/bin/*
              chmod +x $out/bin/*
            '';
          };
          desktopItem = makeDesktopItem {
            inherit name;
            desktopName = name;
            exec = "${script}/bin/${name}";
          };
        in
        symlinkJoin {
          inherit name;
          paths = [ script ] ++ lib.optional config.customScripts.${name}.asDesktopItem desktopItem;
        }
      );
  };
}
