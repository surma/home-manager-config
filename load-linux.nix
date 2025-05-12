{ nixpkgs, home-manager, ... }@args:
{ system, machine }:
let
  pkgs = nixpkgs.legacyPackages.${system};
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [ machine ];

  extraSpecialArgs = args;
}
