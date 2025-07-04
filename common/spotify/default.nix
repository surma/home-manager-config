{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) makeDesktopItem;
  inherit (config.programs) spotify;

  desktopItem = makeDesktopItem {
    name = "spotify";
    desktopName = "Spotify";
    exec = "${spotify.package}/bin/spotify --ozone-platform=${spotify.platform}";
  };
in
with lib;
{
  options = {
    programs.spotify = {
      enable = mkEnableOption "";
      package = mkPackageOption pkgs "spotify" { };
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
    home.packages = mkIf spotify.enable [
      (if spotify.platform != "auto" then desktopItem else spotify.package)
    ];

  };
}
