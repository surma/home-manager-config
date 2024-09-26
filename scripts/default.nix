{ stdenv, lib }:
stdenv.mkDerivation {
  name = "scripts";
  src = lib.cleanSourceWith {
    filter = path: _type: !lib.strings.hasSuffix ".nix" path;
    src = lib.cleanSource ./.;
  };
  installPhase = ''
    mkdir -p $out/bin
    patchShebangs $src
    cp -r $src/* $out/bin
    chmod +x $out/bin/*
  '';
}
