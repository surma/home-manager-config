{ fetchFromGitHub, system }:
let
  pkgs-unstable = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    # `nixpks-unstable` on Mar 16, 2025
    rev = "573c650e8a14b2faa0041645ab18aed7e60f0c9a";
    hash = "sha256-4thdbnP6dlbdq+qZWTsm4ffAwoS8Tiq1YResB+RP6WE=";
  }) { inherit system; };
in
{
  zig = pkgs-unstable.zig;
  zls = pkgs-unstable.zls;
}
