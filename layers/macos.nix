{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ "raycast" ];

  home.packages =
    prev.home.packages
    ++ (with pkgs; [
      raycast

      (callPackage (import ../extra-pkgs/hyperkey.nix) { })
      (callPackage (import ../extra-pkgs/aerospace-bin.nix) { })
    ]);

  home.file.".config/aerospace/aerospace.toml".source = ../configs/aerospace.toml;
}
