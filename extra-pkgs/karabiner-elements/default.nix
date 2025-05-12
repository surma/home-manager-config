{ fetchFromGitHub, system }:
let
  pkgs = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "e5aa8e21821e0591434db3ab6281569d86ebef30";
    hash = "sha256-65j1No6uE37BPnzIFHUc2ayOTh6oPOWwCtkVnzHemM8=";
  }) { inherit system; };
in
pkgs.karabiner-elements
