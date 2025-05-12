{
  nixpkgs,
  nix-on-droid,
  home-manager,
  # lib,
  ...
}@args:
{
  system,
  hmModules,
  droidModules,
}:
let
  loadConfig = import ./load-config.nix args;

  hmConfig = loadConfig system hmModules;
  userData = {
    inherit (hmConfig.config.home) username homeDirectory;
  };
  pkgs = import args.nixpkgs {
    inherit system;

    overlays = [
      nix-on-droid.overlays.default
    ];
  };

in

nix-on-droid.lib.nixOnDroidConfiguration {
  inherit pkgs;
  modules = droidModules ++ [
    {
      home-manager = {
        # users.${userData.username}.imports = hmModules;
      config = hmConfig.config;
      # config = ./modules/base.nix;
      # config = pkgs.callPackage ./modules/base.nix args;
        # config = [./modules/base.nix ./modules/physical.nix];
        # config = hmConfig;
        extraSpecialArgs = args;
      };
    }
  ];
  home-manager-path = home-manager.outPath;
}
