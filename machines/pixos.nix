{ config, pkgs, ... }:
{
  config = {
    home.packages = (with pkgs; [ clang ]);

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#pixos";
  };
}
