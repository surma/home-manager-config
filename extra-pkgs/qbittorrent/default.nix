{ fetchFromGitHub, system }:
let
  pkgs-unstable = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "69b9a8c860bdbb977adfa9c5e817ccb717884182";
    hash = "sha256-yumd4fBc/hi8a9QgA9IT8vlQuLZ2oqhkJXHPKxH/tRw=";
  }) { inherit system; };
in
pkgs-unstable.qbittorrent
