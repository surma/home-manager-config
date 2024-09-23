{ nixpkgs, home-manager, ... }@args:
system: paths:
let
  pkgs = nixpkgs.legacyPackages.${system};
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = paths;

  extraSpecialArgs = args;
}
