{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = {
    wayland.windowManager.hyprland = {
      extraConfig = lib.readFile ../configs/hyprland.conf;
    };
  };
}
