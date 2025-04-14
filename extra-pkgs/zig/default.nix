{ fetchFromGitHub, system }:
let
  nixpkgs-unstable-rev = import ../nixpkgs-unstable.nix;
  pkgs-unstable = import (fetchFromGitHub nixpkgs-unstable-rev) { inherit system; };
in
{
  zig = pkgs-unstable.zig;
  zls = pkgs-unstable.zls;
}
