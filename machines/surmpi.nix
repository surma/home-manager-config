{ config, pkgs, ... }:
{
  config = {
    home.packages = (with pkgs; [ syncthing ]);

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmpi";
  };
}
