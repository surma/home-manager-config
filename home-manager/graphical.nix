{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./unfree-apps.nix

    ./wezterm
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
    defaultConfigs.wezterm.enable = true;
  };
}
