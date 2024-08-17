{ buildNpmPackage, nodejs }:
buildNpmPackage {
  inherit nodejs;

  name = "patch-electron-builder-config";
  src = ./.;

  npmDepsHash = "sha256-eYJgkcrGTyD7LvfC26zADtWcMx++TEyQ9+6mRbd7tyA=";

  dontNpmBuild = true;
}
