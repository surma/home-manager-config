{
  nixpkgs,
  nix-on-droid,
  home-manager,
  # lib,
  ...
}@args:
{
  system,
  machine,
}:
let
  pkgs = import args.nixpkgs {
    inherit system;

    overlays = [
      nix-on-droid.overlays.default
    ];
  };

in

nix-on-droid.lib.nixOnDroidConfiguration {
  inherit pkgs;
  modules = [
    machine
    {
      home-manager = {
        config =
          { lib, ... }:
          {
            config = {

              home.username = lib.mkDefault "nix-on-droid";
              home.homeDirectory = lib.mkDefault "/data/data/com.termux.nix/files/home";
              home.sessionVariables = {
                CONFIG_MANAGER = "nix-on-droid";
              };

            };
          };

        extraSpecialArgs = args;
      };
    }
  ];
  home-manager-path = home-manager.outPath;
}
