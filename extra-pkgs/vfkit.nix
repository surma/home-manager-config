{
  fetchFromGitHub,
  go,
  stdenv,
  writeShellScriptBin,
  bash,
}:
let
  version = "0.5.1";
  src = fetchFromGitHub {
    owner = "crc-org";
    repo = "vfkit";
    rev = "v${version}";
    hash = "sha256-9iPr9VhN60B6kBikdEIFAs5mMH+VcmnjGhLuIa3A2JU=";
  };
  impureSigning = writeShellScriptBin "codesign" ''
    #!${bash}/bin/bash

    set -e

    /usr/bin/codesign $@
  '';
in
stdenv.mkDerivation {
  name = "vfkit";
  inherit src;

  nativeBuildInputs = [
    go
    impureSigning
  ];
  dontUnpack = false;
  buildPhase = ''
    # This is impure, but I can’t get it to compile any other way.
    export CC=/usr/bin/clang
    export GOCACHE="$TMPDIR/go-cache"
    export GOPATH="$TMPDIR/go"
    make out/vfkit-arm64
  '';
  installPhase = ''
    mkdir -p $out/bin;
    cp out/vfkit-arm64 $out/bin/vfkit;
  '';
  # Stripping removes the code signatures
  dontStrip = true;
}

# Could not get it to build using buildGo*Module
/*
  buildGo121Module {
    name = "vfkit";
    vendorHash = "sha256-6O1T9aOCymYXGAIR/DQBWfjc2sCyU/nZu9b1bIuXEps=";
    # nativeBuildInputs = [xcbuild];
    env = {
      CC = "/usr/bin/clang";
      CGO_CFLAGS="-mmacosx-version-min=11.0";
    };
    CGO_ENABLED=true;
    inherit src;
  }
*/
