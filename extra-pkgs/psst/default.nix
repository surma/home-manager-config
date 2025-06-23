{
  fetchFromGitHub,
  writeShellScriptBin,
  system,
  lib,
  rustPlatform,
}:
let
  nixpkgs-unstable-rev = import ../nixpkgs-unstable.nix;
  pkgs-unstable = import (fetchFromGitHub nixpkgs-unstable-rev) { inherit system; };

  inherit (pkgs-unstable) psst;

  src = fetchFromGitHub {
    owner = "jpochyla";
    repo = "psst";
    rev = "76b6a2acc1e79a42d7769a62bf5e5152b201e302";
    hash = "sha256-rikKZ442quNCZAdTI6j8Iy73L6HnikSeNR3E1j+EvcI=";
  };
  patchedPsst = psst.overrideAttrs (oldAttrs: {
    inherit src;
    version = "2025.06.22-76b6a2a";
    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-u5UqNtzZ+654EPl68g5gsAeSWYyBkzNGjZo24ON6Al8=";
    };
    # cargoDeps = oldAttrs.cargoDeps.overrideAttrs {
    #   inherit src;
    #   outputHash = "sha256-u5UqNtzZ+654EPl68g5gsAeSWYyBkzNGjZo24ON6Al8=";
    # };
    # cargoDeps = null;
    # cargoHash = "sha256-u5UqNtzZ+654EPl68g5gsAeSWYyBkzNGjZo24ON6Al8=";
  });
in
patchedPsst
