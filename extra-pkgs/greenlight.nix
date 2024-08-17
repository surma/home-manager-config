{
  fetchFromGitHub,
  nodejs,
  fetchYarnDeps,
  mkYarnPackage,
  writeShellScriptBin,
  undmg,
  which,
  python3,
  darwin,
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

  hdiutil = writeShellScriptBin "hdiutil" ''
    exec /usr/bin/hdiutil "$@"
  '';

  sips = writeShellScriptBin "sips" ''
    exec /usr/bin/sips "$@"
  '';
in
# workspace = mkYarnPackage { inherit src; };
# url = "https://github.com/unknownskl/greenlight/archive/refs/tags/${version}.tar.gz";
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
    hdiutil
    sips
    which
    python3
    undmg
    # darwin.sigtool
  ];

  # patchPhase = ''
  #   substituteInPlace ./package.json \
  #     --replace '$(git rev-parse --short HEAD)' "${src.rev}" \
  #     --replace 'yarn clean' 'yarn --offline clean' \
  #     --replace 'yarn run rimraf dist' 'yarn --offline run rimraf dist'
  # '';

  dontPatch = true;
  configurePhase = ''
    ln -s $node_modules node_modules
  '';

  # yarnPreBuild = ''
  # '';

  buildPhase = ''
    export npm_config_nodedir=${nodejs}
    # Yarn writes cache directories etc to $HOME.
    export HOME=$TMPDIR/yarn_home

    # ln -sf $PWD/node_modules $PWD/deps/lemmy-ui/
    # echo 'export const VERSION = "${version}";' > $PWD/deps/lemmy-ui/src/shared/version.ts

    yarn --offline build
  '';

  installPhase = ''
    mkdir -p $out/Applications

    cp -R ./dist/mac-universal/Greenlight.app $out/Applications/
    # undmg dist/Greenlight*.dmg;
    # cp -R ./deps/lemmy-ui/dist $out
    # cp -R ./node_modules $out
  '';
  dontFix = true;

  doDist = false;
  # distPhase = "true";

  # passthru.updateScript = ./update.py;
  # passthru.commit_sha = src.rev;

  # meta = with lib; {
  #   description = "Building a federated alternative to reddit in rust";
  #   homepage = "https://join-lemmy.org/";
  #   license = licenses.agpl3Only;
  #   maintainers = with maintainers; [ happysalada billewanick ];
  #   inherit (nodejs.meta) platforms;
  # };
}
