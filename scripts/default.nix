{
  stdenv,
  lib,
  pkgs,
}:
let
  inherit (pkgs) nushell;
in
stdenv.mkDerivation {
  name = "scripts";
  buildInputs = [ nushell ];
  src = lib.cleanSourceWith {
    filter = path: _type: !lib.strings.hasSuffix ".nix" path;
    src = lib.cleanSource ./.;
  };
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin
    patchShebangs $out/bin/*
    chmod +x $out/bin/*
  '';
}
