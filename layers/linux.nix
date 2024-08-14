{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  home.username = "surma";
  home.homeDirectory = "/home/surma";

  nixpkgs.config.allowUnfreePredicate =
    pkg: (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ ];

  home.packages = prev.home.packages ++ (with pkgs; [ ]);
}
