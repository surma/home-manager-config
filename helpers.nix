args@{ nixpkgs, home-manager, ... }:
let
  inherit (nixpkgs) lib;
  loadConfig =
    system: path:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (pkgs) callPackage;
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [ (callPackage (import path) (args // { inherit system pkgs; })) ];
    };
in
loadConfig
