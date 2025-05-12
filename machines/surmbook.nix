{ pkgs, config, ... }:
let
  inherit (pkgs) callPackage;
in
{
  imports = [
    ../darwin/base.nix
  ];
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
        ../modules/base.nix
        ../modules/graphical.nix
        ../modules/workstation.nix
        ../modules/physical.nix
        ../modules/macos.nix
      ];

      home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmbook";

      home.packages =
        (with pkgs; [
          darktable
          utm
          google-cloud-sdk
          opentofu
          openscad
          jqp
          uv
          deno
        ])
        ++ [
          # (callPackage (import ../extra-pkgs/vfkit) { })
          (callPackage (import ../extra-pkgs/qbittorrent) { })
        ];
    };
}
