{
  nixpkgs,
  nix-darwin,
  home-manager,
  system-manager,
  nix-system-graphics,
  ...
}@inputs:
{ machine, system }:
let

  userModule =
    { lib, ... }:
    with lib;
    {
      options = {
        # users = mkOption {
        #   type = types.attrsOf types.unspecified;
        #   default = null;
        #   description = "Currently a no-op, but present for home-manager compatibilty";
        # };
      };
      config = {
        users.users.surma = {
          name = "surma";
          home = "/home/surma";
        };
      };
    };

  extraModule = {
    nixpkgs.hostPlatform = system;
    # home-manager.extraSpecialArgs = {
    #     inherit inputs system;
    #     systemManager = "home-manager";
    # };
  };
in
system-manager.lib.makeSystemConfig {
  modules = [
    nix-system-graphics.systemModules.default
    # home-manager.nixosModules.home-manager
    ./system-manager/home-manager.nix
    # ./system-manager/old-home-manager.nix
    userModule
    machine
    extraModule
  ];
  extraSpecialArgs = {
    inherit inputs system;
    systemManager = "system-manager";
  };
}
