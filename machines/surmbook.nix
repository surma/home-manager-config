{ pkgs, config, ... }:
let
  inherit (pkgs) callPackage;
in
{
  imports = [
    ../darwin/base.nix

    ../common/signal
    ../common/obs
  ];

  system.stateVersion = 5;

  homebrew = {
    casks = [
      "nvidia-geforce-now"
      "magicavoxel"
    ];
  };

  ids.gids.nixbld = 30000;

  programs.signal.enable = true;
  programs.obs.enable = true;

  home-manager.users.${config.system.primaryUser} =
    { config, amber-upstream, ... }:
    {
      imports = [
        ../home-manager/opencode.nix

        ../home-manager/unfree-apps.nix

        ../home-manager/base.nix
        ../home-manager/graphical.nix
        ../home-manager/keyboard-dev.nix
        ../home-manager/workstation.nix
        ../home-manager/physical.nix
        ../home-manager/macos.nix
        ../home-manager/experiments.nix
        ../home-manager/cloud.nix
        ../home-manager/nixdev.nix
        ../home-manager/opencode-defaults.nix
        ../home-manager/javascript.nix
        ../home-manager/dev.nix
      ];

      home.stateVersion = "24.05";

      home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmbook";

      home.packages =
        (with pkgs; [
          openscad
          jqp
        ])
        ++ [
          (callPackage (import ../extra-pkgs/ollama) { })
          (callPackage (import ../extra-pkgs/jupyter) { })
          # (callPackage (import ../extra-pkgs/vfkit) {
          (callPackage (import ../extra-pkgs/qbittorrent) { })
          (callPackage (import ../extra-pkgs/amber) { inherit amber-upstream; })
        ];
    };
}
