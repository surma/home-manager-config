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
          # qbittorrent
          # mgba
          # vcv-rack
          # davinci-resolve
        ]);

      programs.zsh.shellAliases = {
        hms = "home-manager switch -A surmserver";
      };
    };
  helpers = import ../helpers.nix;
in
helpers.applyOverlays [
  ../layers/base.nix
  overlay
] args
