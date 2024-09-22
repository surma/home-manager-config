args@{ pkgs, lib, ... }:
let
  applyOverlays = import ../apply-overlays.nix args;
  overlay =
    final: prev:
    lib.recursiveUpdate prev {
      nixpkgs.config.allowUnfreePredicate =
        pkg: (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ ];

      home.packages = prev.home.packages ++ (with pkgs; [ ]);

      home.sessionVariables.FLAKE_CONFIG_URI = "path:${final.home.homeDirectory}/.config/home-manager#surmpi";
    };
in
applyOverlays [
  ../layers/base.nix
  ../layers/linux.nix
  ../layers/workstation.nix
  overlay
]
