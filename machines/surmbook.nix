args@{ pkgs, lib, ... }:
let
  overlay =
    final: prev:
    lib.recursiveUpdate prev {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        (prev.nixpkgs.config.allowUnfreePredicate pkg)
        || builtins.elem (lib.getName pkg) [
          # "vcv-rack" 
        ];

      home.packages =
        prev.home.packages
        ++ (with pkgs; [
          qbittorrent
          darktable
          utm
          google-cloud-sdk
          # mgba
          # vcv-rack
          # davinci-resolve
        ])
        ++ [ (pkgs.callPackage (import ../extra-pkgs/greenlight) { }) ];

      programs.zsh.shellAliases = {
        hms = "home-manager switch -A surmbook";
      };
    };
  helpers = import ../helpers.nix;
in
helpers.applyOverlays [
  ../layers/base.nix
  ../layers/graphical.nix
  ../layers/workstation.nix
  ../layers/macos.nix
  overlay
] args
