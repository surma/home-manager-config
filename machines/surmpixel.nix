{ config, pkgs, ... }:
{
  config = {
    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmpixel";
    home.stateVersion = "24.05";
  };
}
