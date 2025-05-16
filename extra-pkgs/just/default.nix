{ fetchFromGitHub, system }:
let
  nixpkgs-unstable-rev = import ../nixpkgs-unstable.nix;
  pkgs-unstable = import (fetchFromGitHub nixpkgs-unstable-rev) { inherit system; };
in
pkgs-unstable.just
