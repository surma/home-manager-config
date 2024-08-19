{ buildNpmPackage, nodejs }:
buildNpmPackage {
  inherit nodejs;

  name = "patch-electron-builder-config";
  src = ./.;

  npmDepsHash = "sha256-Be2wgI6S5eIPMa+r9M6qYUa3hwvgzxms/TXic4Noc14=";

  dontNpmBuild = true;
}
