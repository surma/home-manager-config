{ config, pkgs, ... }:
{
  config = {
    home.packages = (with pkgs; [ ]);

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#pixos";
  };
}
