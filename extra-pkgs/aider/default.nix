{ fetchFromGitHub, system }:
let
  pkgs-unstable = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    # nixpkgs-unstable @ Feb 9, 2025
    rev = "aa2fb254dfb0da9ce519fdaa6360bceef5ef955c";
    hash = "sha256-3x8OEvtnyuZH6cagU1d2oeoXkHahlboSY9JWTDw0rn0=";
  }) { inherit system; };
in
pkgs-unstable.aider-chat
