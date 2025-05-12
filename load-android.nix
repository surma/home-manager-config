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
        config = {
          imports = hmModules;
        };
        extraSpecialArgs = args;
      };
    }  ];
  home-manager-path = home-manager.outPath;
}
