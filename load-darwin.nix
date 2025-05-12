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
  pkgs = nixpkgs.legacyPackages.${system};
  inherit (pkgs) lib;

  loadConfig = import ./load-config.nix args;

  hmConfig = loadConfig system hmModules;
  userData = {
    inherit (hmConfig.config.home) username homeDirectory;
  };
in

nix-darwin.lib.darwinSystem {
  system = system;
  modules = darwinModules ++ [
    args.home-manager.darwinModules.home-manager
    {
      users.users.surma = {
        name = userData.username;
        home = userData.homeDirectory;
      };

      home-manager = {
        users.${userData.username}.imports = hmModules;
        extraSpecialArgs = args;
      };
    }
  ];
}
