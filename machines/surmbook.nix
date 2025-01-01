{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  config = {

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmbook";

    home.packages =
      (with pkgs; [
        darktable
        utm
        google-cloud-sdk
        opentofu
      ])
      ++ [
        (callPackage (import ../extra-pkgs/greenlight) { })
        (callPackage (import ../extra-pkgs/vfkit) { })
        (callPackage (import ../extra-pkgs/qbittorrent) { })
      ];
  };
}
