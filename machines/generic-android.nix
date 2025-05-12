{ config, pkgs, ... }:
{
  imports = [
    ../nix-on-droid/base.nix
  ];
  home-manager =
    { config, ... }:
    {
      imports = [
        ../home-manager/base.nix
      ];

      home.stateVersion = "24.05";

      home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmpixel";
    };
}
