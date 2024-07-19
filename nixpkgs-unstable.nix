{
  pkgs ? import <nixpkgs> { },
}:
import (
  pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "cfa5366588c940ab6ee3bee399b337175545c664";
    hash = "sha256-7sv0Ab1bahsM3OPG9LNjU8rI6JEIEooXWaDoAvIFPgc=";
  }
)
