{
  nixpkgs,
  nix-darwin,
  home-manager,
  ...
}@args:
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
          extraSpecialArgs = args;
        };
      };
    };
in

nix-darwin.lib.darwinSystem {
  system = system;
  modules = [
    machine
    home-manager.darwinModules.home-manager
    extraModule
  ];
}
