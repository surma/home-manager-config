{ config, pkgs, ... }:
{
  config = {

    home.packages = (
      with pkgs;
      [
        google-cloud-sdk
        sqlite
      ]
    );

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmserver";
  };
}
