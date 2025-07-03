{
  nixpkgs,
  home-manager,
  ...
}@inputs:
{ machine, system }:
nixpkgs.lib.nixosSystem rec {
  inherit system;
  modules = [
    machine
    home-manager.darwinModules.home-manager
  ];
  specialArgs = {
    inherit inputs system;
    systemManager = "nixos";
  };
}
