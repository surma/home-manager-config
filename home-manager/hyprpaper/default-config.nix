{
  pkgs,
  config,
  lib,
  ...
}:
let
  defaultWallpaper = ../../wallpapers/manifold0.jpg;
in
with lib;
{
  options = {
    defaultConfigs.hyprpaper = {
      enable = mkEnableOption "";
    };
  };
  config = mkIf (config.defaultConfigs.hyprpaper.enable) {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ${defaultWallpaper}
      wallpaper =,${defaultWallpaper}
    '';
  };
}
