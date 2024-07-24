{
  lib,
  fetchurl,
  stdenv,
  installShellFiles,
  unzip,
}:
let
  version = "v0.12.0-Beta";
  url = "https://github.com/nikitabobko/AeroSpace/releases/download/${version}/AeroSpace-${version}.zip";
  zipFile = fetchurl {
    inherit url;
    hash = "sha256-iAEwG16scvqm2uBHl8t2gOsXXf0jyKDNfpChu7WBElc=";
  };
in
stdenv.mkDerivation rec {
  pname = "aerospace";
  inherit version;

  src = zipFile;

  nativeBuildInputs = [
    installShellFiles
    unzip
  ];

  unpackPhase = ''
    runHook preUnpack;

    unzip ${src}
    mv AeroSpace*/* .

    runHook postUnpack;
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -r AeroSpace.app $out/Applications
    cp -r bin $out/

    runHook postInstall
  '';

  postInstall = ''
    installManPage manpage/*
    installShellCompletion --cmd aerospace \
      --zsh shell-completion/zsh/_aerospace \
      --bash shell-completion/bash/aerospace \
      --fish shell-completion/fish/aerospace.fish
  '';

  meta = {
    description = "AeroSpace is an i3-like tiling window manager for macOS";
    homepage = "https://github.com/nikitabobko/AeroSpace/";
    downloadPage = "https://github.com/nikitabobko/AeroSpace/releases";
    license = lib.licenses.mit;
    # maintainers = [ ];
    platforms = lib.platforms.darwin;
    mainProgram = "aerospace";
  };
}
