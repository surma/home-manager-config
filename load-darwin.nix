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
      options = with lib; {
        adminUser = mkOption {
          type = types.str;
          default = "surma";
        };
      };
      config = {
        users.users.${config.adminUser} = {
          name = config.adminUser;
          home = "/Users/${config.adminUser}";
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
