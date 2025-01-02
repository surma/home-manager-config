{ fetchFromGitHub, rustPlatform }:
let
  version = "0.48.0";
  src = fetchFromGitHub {
    owner = "dprint";
    repo = "dprint";
    rev = "${version}";
    hash = "sha256-Zem37oHku90c7PDV8ep/7FN128eGRUvfIvRsaXa7X9g=";
  };
in
rustPlatform.buildRustPackage {
  inherit version src;
  pname = "dprint";

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  doCheck = false;
}
