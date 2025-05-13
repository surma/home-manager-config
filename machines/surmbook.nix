{ pkgs, config, ... }:
let
  inherit (pkgs) callPackage;
in
{
  imports = [
    ../darwin/base.nix
  ];

  system.stateVersion = 5;

  homebrew = {
    casks = [
      "nvidia-geforce-now"
      "magicavoxel"
    ];
  };

  home-manager.users.${config.adminUser} =
    { config, ... }:
    {
      imports = [
        ../home-manager/base.nix
        ../home-manager/graphical.nix
        ../home-manager/workstation.nix
        ../home-manager/physical.nix
        ../home-manager/macos.nix
      ];

      home.stateVersion = "24.05";

      home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmbook";

      home.packages =
        (with pkgs; [
          google-cloud-sdk
          opentofu
          openscad
          jqp
          uv
          qmk
        ])
        ++ [
          # (callPackage (import ../extra-pkgs/vfkit) { })
          (callPackage (import ../extra-pkgs/qbittorrent) { })
        ];
    };
}
