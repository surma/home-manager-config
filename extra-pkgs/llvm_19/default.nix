{ fetchFromGitHub, system }:
let
  pkgs-unstable = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "69b9a8c860bdbb977adfa9c5e817ccb717884182";
    hash = "sha256-Jks8O42La+nm5AMTSq/PvM5O+fUAhIy0Ce1QYqLkyZ4=";
  }) { inherit system; };
in
pkgs-unstable.llvmPackages_19
