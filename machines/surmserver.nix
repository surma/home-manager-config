{ config, pkgs, ... }:
{

  imports = [
    ../home-manager/base.nix
    ../home-manager/linux.nix
    ../home-manager/workstation.nix
  ];

  home.stateVersion = "24.05";

  home.packages = (
    with pkgs;
    [
      google-cloud-sdk
      sqlite
    ]
  );

  home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/src/github.com/surma/nixenv#surmserver";

  programs.yt-dlp.enable = true;
}
