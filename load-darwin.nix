{
  nixpkgs,
  nix-darwin,
  home-manager,
  ...
}@inputs:
{ machine, system }:
let
  extraModule =
    { config, lib, ... }:
    {
      config = {
        users.users.${config.system.primaryUser} = {
          name = config.system.primaryUser;
          home = "/Users/${config.system.primaryUser}";
        };

        home-manager = {
          backupFileExtension = "bak";
          extraSpecialArgs = inputs;
        };
      };
    };
in
nix-darwin.lib.darwinSystem {
  inherit system;
  modules = [
    machine
    home-manager.darwinModules.home-manager
    extraModule
  ];
  specialArgs = {
    inherit inputs system;
    systemManager = "nix-darwin";
  };
}
