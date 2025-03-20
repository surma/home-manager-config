{ fetchFromGitHub, rustPlatform }:
let
  version = "0.49.1";
  src = fetchFromGitHub {
    owner = "dprint";
    repo = "dprint";
    rev = "${version}";
    hash = "sha256-6ye9FqOGW40TqoDREQm6pZAQaSuO2o9SY5RSfpmwKV4=";
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
