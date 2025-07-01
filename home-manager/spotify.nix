{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) makeDesktopItem;
  mkSpotifyWrapper =
    spotify:
    makeDesktopItem {
      name = "spotify";
      desktopName = "Spotify";
      exec = "${spotify.package}/bin/spotify --ozone-platform=${spotify.platform}";
    };
in
with lib;
{
  options = {
    programs.spotify = {
      enable = mkEnableOption "Spotify";
      package = mkPackageOption pkgs "spotify" { };
      platform = mkOption {
        type =
          with types;
          enum [
            "wayland"
            "x11"
            "auto"
          ];
        default = "wayland";
      };
    };
  };

  config = {
    home.packages = mkIf config.programs.spotify.enable [ (mkSpotifyWrapper config.programs.spotify) ];
  };
}
