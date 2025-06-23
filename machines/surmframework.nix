{ config, pkgs, ... }:
{
  imports = [

    ../home-manager/base.nix
    ../home-manager/dev.nix
    ../home-manager/nixdev.nix
    ../home-manager/linux.nix
    ../home-manager/graphical.nix
    ../home-manager/workstation.nix
  ];
  home.packages = (
    with pkgs;
    [
      # hyprland
    ]
  );

  home.stateVersion = "24.05";

  home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";

  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = false;
    extraConfig = ''
      # lol
    '';
    # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
