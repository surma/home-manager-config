{
  pkgs ? import <nixpkgs> { },
}:
with pkgs;
stdenv.mkDerivation {
  name = "scripts";
  src = lib.cleanSourceWith {
    filter = path: _type: !lib.strings.hasSuffix ".nix" path;
    src = lib.cleanSource ./.;
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin
    chmod +x $out/bin/*
  '';
}
