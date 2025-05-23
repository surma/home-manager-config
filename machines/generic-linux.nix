{ config, pkgs, ... }:
{
  imports = [

    ../home-manager/base.nix
    ../home-manager/linux.nix
    ../home-manager/workstation.nix
  ];
  home.packages = (with pkgs; [ ]);

  home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#generic-linux";
}
