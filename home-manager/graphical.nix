{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./wezterm.nix

    ./unfree-apps.nix
  ];

  config = {
    allowedUnfreeApps = [
      "obsidian"
      "vscode"
    ];
    home.packages = (
      with pkgs;
      [
        telegram-desktop
        fira-code
        roboto
        font-awesome
        obsidian
        vscode
      ]
    );

    programs.wezterm.enable = true;
  };
}
