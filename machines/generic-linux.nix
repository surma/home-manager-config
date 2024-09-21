args@{ pkgs, lib, ... }:
let
  overlay =
    final: prev:
    lib.recursiveUpdate prev {
      nixpkgs.config.allowUnfreePredicate =
        pkg: (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ ];

      home.packages = prev.home.packages ++ (with pkgs; [ ]);

      programs.zsh.shellAliases = {
        hms = "home-manager switch -A surmserver";
      };
    };
  helpers = import ../helpers.nix;
in
helpers.applyOverlays [
  ../layers/base.nix
  ../layers/linux.nix
  overlay
] args
