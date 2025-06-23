{ config, pkgs, ... }:
{
  imports = [

    ../home-manager/base.nix
    ../home-manager/dev.nix
    ../home-manager/linux.nix
    ../home-manager/workstation.nix
  ];
  home.packages = (with pkgs; [ ]);

  home.stateVersion = "24.05";

  home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";
}
