{ config, pkgs, lib, ... }:
{
  imports = [
    ../home-manager/base.nix
    ../home-manager/dev.nix
    ../home-manager/nixdev.nix
    ../home-manager/linux.nix
    ../home-manager/graphical.nix
    ../home-manager/workstation.nix
    ../home-manager/wezterm.nix
  ];

  options = with lib; {
    system-manager = with types; mkOption {
      type = nullOr (submodule {inherit (systemManagerModule) options config imports;});
      default = null;
    };
  };

  config = {
    home.activation.myScript = (lib.hm.dag.entryAfter ["writeBoundary"] ''
      # nix run 'github:numtide/system-manager -- --flake'
    '');

    home.packages = (
      with pkgs;
      [
      ]
    );

    home.stateVersion = "24.05";

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";

    programs.wezterm.frontend = "OpenGL";
    programs.wezterm.theme = "dark";
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = lib.readFile ../configs/hyprland.conf;
    };
  };
}
