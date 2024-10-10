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
  username = hmConfig.config.home.username;
in
nix-darwin.lib.darwinSystem {
  inherit system;

  modules = darwinModules ++ [
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username} = {
          imports = hmModules;
        };
        # home-manager.libw f{
        # 	modules = paths;
        # };
        # # modules = paths;
        extraSpecialArgs = args;
      };
    }
    # hmConfig
  ];
}
