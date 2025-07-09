{
  system-manager,
  nix-system-graphics,
  ...
}@inputs:
{ machine, system }:
system-manager.lib.makeSystemConfig {
  modules = [
    nix-system-graphics.systemModules.default
    ./system-manager/home-manager.nix
    ./system-manager/base.nix
    machine
    (
      { pkgs, config, ... }:
      {
        nixpkgs.hostPlatform = system;
        environment.systemPackages = [
          system-manager.packages.${system}.default
        ];
      }
    )
  ];
  extraSpecialArgs = {
    inherit inputs system;
    systemManager = "system-manager";
  };
}
