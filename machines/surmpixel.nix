{ config, pkgs, ... }:
{
  config = {
    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmpixel";
    home.username = "nix-on-droid";
    home.homeDirectory = "/data/data/com.termux.nix/files/home";
    home.stateVersion = "24.05";
  };
}
