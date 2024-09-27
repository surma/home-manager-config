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
        audacity
        fira-code
        obsidian
        vscode
        vlc-bin
      ]
    );

    programs.wezterm = import ../configs/wezterm.nix;
  };
}
