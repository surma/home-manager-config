{
  fetchFromGitHub,
  buildGo121Module,
  callPackage,
  lib,
}:
let
  version = "0.5.1";
  src = fetchFromGitHub {
    owner = "crc-org";
    repo = "vfkit";
    rev = "v${version}";
    hash = "sha256-9iPr9VhN60B6kBikdEIFAs5mMH+VcmnjGhLuIa3A2JU=";
  };
  codesign = callPackage (import ../impure-codesign) { };
in
buildGo121Module {
  pname = "vfkit";
  inherit version src;
  vendorHash = "sha256-6O1T9aOCymYXGAIR/DQBWfjc2sCyU/nZu9b1bIuXEps=";
  subPackages = "cmd/vfkit";
  postConfigure = ''
    export CC="/usr/bin/clang"
    export CGO_CFLAGS="-mmacosx-version-min=11.0"
  '';
  CGO_ENABLED = true;
  postFixup = ''
    ${codesign}/bin/codesign -f --entitlements ${src}/vf.entitlements -s - $out/bin/vfkit
  '';

  meta = {
    description = "vfkit offers a command-line interface to start virtual machines using the macOS Virtualization framework.";
    homepage = "https://github.com/crc-org/vfkit";
    downloadPage = "https://github.com/crc-org/vfkit";
    # license = lib.licenses.mit;
    # maintainers = [ ];
    platforms = lib.platforms.darwin;
    mainProgram = "vfkit";
  };
}
