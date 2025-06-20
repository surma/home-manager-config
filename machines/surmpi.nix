{ config, pkgs, ... }:
{
  imports = [
    ../home-manager/base.nix
    ../home-manager/linux.nix
    ../home-manager/workstation.nix
    ../home-manager/nixdev.nix
    ../home-manager/javascript.nix
    ../home-manager/dev.nix
  ];

  home.stateVersion = "24.05";

  home.packages = (with pkgs; [ syncthing ]);

  home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmpi";
}
