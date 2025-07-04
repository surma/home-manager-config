{
  name,
  desktopName,
  pkgName ? name,
  binName ? name,
}:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  mkElectronWrapper = pkgs.callPackage (import ./make-electron-wrapper.nix) { };
  appConfig = config.programs.${name};

  wrapper = mkElectronWrapper {
    inherit name desktopName binName;
    inherit (appConfig) platform package;
  };
in
with lib;
{
  options = {
    programs.${name} = {
      enable = mkEnableOption "";
      package = mkPackageOption pkgs pkgName { };
      platform = mkOption {
        type =
          with types;
          enum [
            "wayland"
            "x11"
            "auto"
          ];
        default = "auto";
      };
    };
  };

  config = {
    home.packages = mkIf appConfig.enable [ wrapper ];
  };
}
