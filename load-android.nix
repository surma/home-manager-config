{
  nixpkgs,
  nix-on-droid,
  home-manager,
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
in

nix-on-droid.lib.nixOnDroidConfiguration {
  modules = droidModules ++ [
    {
      home-manager = {
        users.${userData.username}.imports = hmModules;
        extraSpecialArgs = args;
      };
    }
  ];
  pkgs = import args.nixpkgs {
    inherit system;

    overlays = [
      nix-on-droid.overlays.default
    ];
  };

  home-manager-path = home-manager.outPath;
}
