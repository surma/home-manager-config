{
  nixpkgs,
  nix-darwin,
  home-manager,
  system-manager,
  nix-system-graphics,
  ...
}@inputs:
{ machine, system }:
system-manager.lib.makeSystemConfig {
  modules = [
    nix-system-graphics.systemModules.default
    ./system-manager/home-manager.nix
    machine
    {
      nixpkgs.hostPlatform = system;
    }
  ];
  extraSpecialArgs = {
    inherit inputs system;
    systemManager = "system-manager";
  };
}
