{ pkgs, lib, ... }@args:
let
  inherit (pkgs) callPackage;
  applyOverlays = import ../apply-overlays.nix args;
  overlay =
    final: prev:
    lib.recursiveUpdate prev {
      nixpkgs.config.allowUnfreePredicate =
        pkg: (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ ];

      home.sessionVariables.FLAKE_CONFIG_URI = "path:${final.home.homeDirectory}/.config/home-manager#surmbook";

      home.packages =
        prev.home.packages
        ++ (with pkgs; [
          qbittorrent
          darktable
          utm
          google-cloud-sdk
          opentofu
          podman
          podman-compose
        ])
        ++ [ (callPackage (import ../extra-pkgs/greenlight) { }) ];
    };
in
applyOverlays [
  ../layers/base.nix
  ../layers/graphical.nix
  ../layers/workstation.nix
  ../layers/macos.nix
  overlay
]
