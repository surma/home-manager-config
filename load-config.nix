{ nixpkgs, home-manager, ... }@args:
system: path:
let
  pkgs = nixpkgs.legacyPackages.${system};
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [ path ];

  extraSpecialArgs = args;
}
