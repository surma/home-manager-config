{ config, pkgs, ... }:
{
  imports = [
    ../system-manager/base.nix
  ];

  environment.etc = {
    "hostname".text = "surmpi";
  };

  system-manager.allowAnyDistro = true;

  home-manager.users.surma =
    { config, ... }:
    {
      imports = [
        ../home-manager/base.nix
        ../home-manager/linux.nix
        ../home-manager/workstation.nix
        ../home-manager/nixdev.nix
        ../home-manager/javascript.nix
        ../home-manager/dev.nix
      ];

      config = {

        home.stateVersion = "24.05";

        home.packages = (with pkgs; [ syncthing ]);

        home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmpi";
      };
    };
}
