{ fetchFromGitHub, system }:
let
  pkgs = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "250b695f41e0e2f5afbf15c6b12480de1fe0001b";
    hash = "sha256-drDyYyUmjeYGiHmwB9eOPTQRjmrq3Yz26knwmMPLZFk=";
  }) { inherit system; };
in
pkgs.wezterm
