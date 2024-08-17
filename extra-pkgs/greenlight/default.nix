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
}:
let
  version = "2.3.1";

  src = fetchFromGitHub {
    owner = "unknownskl";
    repo = "greenlight";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-3csPU6Qbvrj6nUZFmxg+EIrCs3Z5LwyLceycQp2FXXo=";
  };

  sips = writeShellScriptBin "sips" ''
    exec /usr/bin/sips "$@"
  '';

  patchElectronBuilderConfig = callPackage (import ./patch-electron-builder-config.nix) {
    inherit nodejs;
  };

  systemObj = lib.systems.parse.mkSystemFromString system;
  cpu = systemObj.cpu.name;
  arch = if (cpu == "aarch64") then "arm64" else cpu;

  kernel = systemObj.kernel.name;
  os = if (kernel == "darwin") then "mac" else kernel;
in
mkYarnPackage {
  name = "greenlight";
  inherit version;
  inherit src;

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
    patch-electron-builder-config $PWD/electron-builder.yml $PWD/yarn.lock ${kernel} ${arch} $TMPDIR/ecache
  '';

  configurePhase = ''
    ln -s $node_modules node_modules
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
