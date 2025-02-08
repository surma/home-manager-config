{ fetchFromGitHub, system }:
let
  pkgs-unstable = import (fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "8bff6b79c139a29558c52397eb4b0b2917448172";
    hash = "sha256-KDWyMgpaTVsAIdKs+fmeiXKfuZhsho8NKWze5tOt2x8=";
  }) { inherit system; };
in
pkgs-unstable.ollama
