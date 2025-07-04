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
      "vscode"
    ];
    home.packages = (
      with pkgs;
      [
        fira-code
        roboto
        font-awesome
        vscode
      ]
    );

    programs.wezterm.enable = true;
    defaultConfigs.wezterm.enable = true;
  };
}
