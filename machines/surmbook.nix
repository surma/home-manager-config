{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  config = {

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmbook";

    home.packages =
      (with pkgs; [
        qbittorrent
        darktable
        utm
        google-cloud-sdk
        opentofu
        podman
        podman-compose
      ])
      ++ [
        (callPackage (import ../extra-pkgs/greenlight) { })
        (callPackage (import ../extra-pkgs/vfkit.nix) { })
      ];
  };
}
