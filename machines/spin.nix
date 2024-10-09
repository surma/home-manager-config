{ config, pkgs, ... }:
{
  config = {
    home.packages = (with pkgs; [ ]);

    home.username = "spin";
    home.homeDirectory = "/home/spin";

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#spin";
  };
}
