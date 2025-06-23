{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./wezterm.nix
  ];

  config = {

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      lib.lists.elem (lib.getName pkg) [
        "obsidian"
        "vscode"
      ];
    home.packages = (
      with pkgs;
      [
        telegram-desktop
        fira-code
        obsidian
        vscode
      ]
    );

    programs.wezterm.enable = true;
  };
}
