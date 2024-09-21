{ pkgs, lib, ... }@args:
let
  inherit (pkgs) callPackage;
  applyOverlays = import ../apply-overlays.nix args;
  overlay =
    final: prev:
    lib.recursiveUpdate prev {
      nixpkgs.config.allowUnfreePredicate =
        pkg: (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ ];

      home.packages =
        prev.home.packages
        ++ (with pkgs; [
          qbittorrent
          darktable
          utm
          google-cloud-sdk
          opentofu
        ])
        ++ [ (callPackage (import ../extra-pkgs/greenlight) { }) ];

      programs.zsh.shellAliases = {
        hms = "home-manager switch -A surmbook";
      };
    };
in
(applyOverlays [
  ../layers/base.nix
  ../layers/graphical.nix
  ../layers/workstation.nix
  ../layers/macos.nix
  overlay
])
