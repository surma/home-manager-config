{
  nixpkgs,
  nix-darwin,
  home-manager,
  ...
}@args:
{
  system,
  hmModules,
  darwinModules,
}:
let
  loadConfig = import ./load-config.nix args;

  hmConfig = loadConfig system hmModules;
  userData = {
    inherit (hmConfig.config.home) username homeDirectory;
  };
in

nix-darwin.lib.darwinSystem {
  system = system;
  modules = darwinModules ++ [
    home-manager.darwinModules.home-manager
    {
      users.users.surma = {
        name = userData.username;
        home = userData.homeDirectory;
      };

      home-manager = {
        users.${userData.username}.imports = hmModules;
        backupFileExtension = "bak";
        extraSpecialArgs = args;
      };
    }
  ];
}
