{
  lib,
  fetchFromGitHub,
  jq,
  yq,
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

  srcHash = {
    aarch64-darwin = "sha256-3csPU6Qbvrj6nUZFmxg+EIrCs3Z5LwyLceycQp2FXXo=";
    aarch64-linux = "sha256-Be2wgI6S5eIPMa+r9M6qYUa3hwvgzxms/TXic4Noc14=";
  };
  electronHash = {
    aarch64-darwin = "sha256:1k4dzcmp596fzvqr82drzv6cymarihxxqk706sgfm9a77hrrn493";
    aarch64-linux = "";
  };
  depHash = "sha256-KW98Itndh437Uni9/HtTCSeSF4JqV7lQucDPZbtMyxQ=";

  systemObj = lib.systems.parse.mkSystemFromString system;
  cpu = systemObj.cpu.name;
  arch = if (cpu == "aarch64") then "arm64" else cpu;

  kernel = systemObj.kernel.name;
  os = if (kernel == "darwin") then "mac" else kernel;

  src = fetchFromGitHub {
    owner = "unknownskl";
    repo = "greenlight";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = srcHash.${system};
  };

  yarnlock-to-json = callPackage (import ./yarnlock-to-json) { };
  electronVersion = lib.readFile (
    stdenv.mkDerivation {
      name = "electron-version";
      inherit src;
      nativeBuildInputs = [
        yarnlock-to-json
        jq
      ];
      phases = [
        "unpackPhase"
        "buildPhase"
      ];
      buildPhase = ''
        cat yarn.lock | \
        yarnlock-to-json  | \
        jq -j 'to_entries | map(select(.key | startswith("electron@"))) | .[0].value.version' > $out
      '';
    }
  );

  electronCache =
    let
      name = "electron-v${electronVersion}-${kernel}-${arch}";
    in
    stdenv.mkDerivation {
      name = "electron-zip";
      tarball = builtins.fetchurl {
        url = "https://github.com/electron/electron/releases/download/v${electronVersion}/${name}.zip";
        sha256 = electronHash.${system};
      };
      dontUnpack = true;
      phases = [ "buildPhase" ];
      buildPhase = ''
        mkdir -p $out
        cp $tarball $out/${name}.zip
      '';
    };

  sips = writeShellScriptBin "sips" ''
    exec /usr/bin/sips "$@"
  '';
in
mkYarnPackage {
  pname = "greenlight";
  inherit version;
  inherit src;
  inherit electronCache;

  packageJSON = "${src}/package.json";
  offlineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = depHash;
  };

  nativeBuildInputs = [
    sips
    which
    python3
    undmg
    yq
  ];

  patchPhase = ''
    mv electron-builder.yml{,.old}
    cat electron-builder.yml.old | \
    yq -y '. + {"electronDownload": {"arch": "${arch}", "platform": "${kernel}", "version": "${electronVersion}", "cache": "'$electronCache'"}} | .mac.target = [{"target": "dir", "arch": "${arch}"}] | .linux.target = [{"target": "dir", "arch": "${arch}"}]' > electron-builder.yml
  '';

  configurePhase = ''
    ln -s $node_modules node_modules
  '';

  buildPhase = ''
    yarn --offline build
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -R ./dist/${os}-${arch}/Greenlight.app $out/Applications/
  '';
  dontFix = true;

  doDist = false;

  # passthru.updateScript = ./update.py;

  meta = {
    description = "Greenlight is an open-source client for xCloud and Xbox home streaming made in Typescript.";
    homepage = "https://github.com/unknownskl/greenlight";
    downloadPage = "https://github.com/unknownskl/greenlight";
    # license = lib.licenses.mit;
    # maintainers = [ ];
    platforms = [ lib.platforms.darwin ];
    mainProgram = "Greenlight.app";
  };
}
