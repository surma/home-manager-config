{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../home-manager/base.nix
    ../home-manager/dev.nix
    ../home-manager/nixdev.nix
    ../home-manager/linux.nix
    ../home-manager/graphical.nix
    ../home-manager/workstation.nix
    ../home-manager/wezterm.nix
    ../home-manager/hyprland.nix
    ../home-manager/waybar.nix
  ];

  config = {
    home.packages = (
      with pkgs;
      [
      ]
    );

    home.stateVersion = "24.05";

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";

    programs.wezterm.frontend = "OpenGL";
    programs.wezterm.theme = "dark";
    programs.wezterm.window-decorations = null;
    programs.waybar.enable = true;
    wayland.windowManager.hyprland.enable = true;
  };
}
