{
  config,
  pkgs,
  lib,
  ...
}:
{

  options.allowUnfree.graphical = {
    "obsidian" = true;
    "vscode" = true;
  };

  config = {
    home.packages = (
      with pkgs;
      [
        telegram-desktop
        fira-code
        obsidian
        vscode
      ]
    );

    programs.wezterm = (pkgs.callPackage (import ../configs/wezterm.nix) { }).wezterm;
  };
}
