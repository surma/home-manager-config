{ config, pkgs, ... }:
{
  imports = [
  ];

  networking.hostName = "surmpi";

  system-manager.allowAnyDistro = true;

  users.users.surma = {
    name = "surma";
    home = "/home/surma";
  };

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

        ../home-manager/claude-code
      ];

      config = {

        home.stateVersion = "24.05";

        home.packages = (with pkgs; [ syncthing ]);

        home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/src/github.com/surma/nixenv#surmpi";

        programs.claude-code.enable = true;
        defaultConfigs.claude-code.enable = true;
      };
    };
}
