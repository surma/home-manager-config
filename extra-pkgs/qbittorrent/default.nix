{ fetchFromGitHub, system }:
let
  pkgs-unstable = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "c31898adf5a8ed202ce5bea9f347b1c6871f32d1";
    hash = "sha256-yumd4fBc/hi8a9QgA9IT8vlQuLZ2oqhkJXHPKxH/tRw=";
  }) { inherit system; };
in
pkgs-unstable.qbittorrent
