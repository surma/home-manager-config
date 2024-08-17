{
  lib,
  fetchFromGitHub,
  nodejs,
  fetchYarnDeps,
  mkYarnPackage,
  writeShellScriptBin,
  undmg,
  which,
  python3,
  callPackage,
  system,
  stdenv,
}:
let
  version = "2.3.1";

  downloadElectron =
    {
      version,
      arch,
      os,
      hash,
    }:
    let
      name = "electron-v${version}-${os}-${arch}";
    in
    stdenv.mkDerivation {
      inherit name;
      tarball = builtins.fetchurl {
        url = "https://github.com/electron/electron/releases/download/v${version}/${name}.zip";
        sha256 = hash;
      };
      dontUnpack = true;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out
        cp $tarball $out/${name}.zip
      '';
    };

  src = fetchFromGitHub {
    owner = "unknownskl";
    repo = "greenlight";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-3csPU6Qbvrj6nUZFmxg+EIrCs3Z5LwyLceycQp2FXXo=";
  };

  electronCache = downloadElectron {
    version = "28.2.2";
    arch = "arm64";
    os = "darwin";
    hash = "sha256:1k4dzcmp596fzvqr82drzv6cymarihxxqk706sgfm9a77hrrn493";
  };

  sips = writeShellScriptBin "sips" ''
    exec /usr/bin/sips "$@"
  '';

  patchElectronBuilderConfig = callPackage (import ./patch-electron-builder-config) {
    inherit nodejs;
  };

  systemObj = lib.systems.parse.mkSystemFromString system;
  cpu = systemObj.cpu.name;
  arch = if (cpu == "aarch64") then "arm64" else cpu;

  kernel = systemObj.kernel.name;
  os = if (kernel == "darwin") then "mac" else kernel;
in
mkYarnPackage {
  pname = "greenlight";
  inherit version;
  inherit src;
  inherit electronCache;

  packageJSON = "${src}/package.json";
  offlineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-KW98Itndh437Uni9/HtTCSeSF4JqV7lQucDPZbtMyxQ=";
  };

  nativeBuildInputs = [
    sips
    which
    python3
    undmg
    patchElectronBuilderConfig
  ];

  patchPhase = ''
    patch-electron-builder-config $PWD/electron-builder.yml $PWD/yarn.lock ${kernel} ${arch} $TMPDIR/cache
  '';

  configurePhase = ''
    ln -s $node_modules node_modules
    mkdir -p $TMPDIR/cache
    cp $electronCache/* $TMPDIR/cache/
  '';

  buildPhase = ''
    export npm_config_nodedir=${nodejs}
    # Yarn writes cache directories etc to $HOME.
    export HOME=$TMPDIR/yarn_home

    yarn --offline build
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -R ./dist/${os}-${arch}/Greenlight.app $out/Applications/
  '';
  dontFix = true;

  doDist = false;

  # passthru.updateScript = ./update.py;
}
