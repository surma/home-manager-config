{ buildNpmPackage, nodejs }:
buildNpmPackage {
  inherit nodejs;

  name = "patch-electron-builder-config";
  src = ./.;

  npmDepsHash = "sha256-/5FFY9TyMEjSx2ZLkdRC+oZaDwvIRl0llEDWj2cPXhU=";

  dontNpmBuild = true;
}
