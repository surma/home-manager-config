{
  pkgs ? import <nixpkgs> { },
}:
let 
  pkgs-unstable = import (
    pkgs.fetchFromGitHub {
      owner = "nixos";
      repo = "nixpkgs";
      rev = "280db3decab4cbeb22a4599bd472229ab74d25e1";
      hash = "sha256-Jks8O42La+nm5AMTSq/PvM5O+fUAhIy0Ce1QYqLkyZ4=";
    }
  ) {};
in
  pkgs-unstable.ollama
