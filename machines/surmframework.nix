{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../home-manager/unfree-apps.nix
    ./surmframework-hardware.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
    inputs.home-manager.nixosModules.home-manager
    ../nixos/base.nix
    ../nixos/hyprland.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "surmframework"; # Define your hostname.
  allowedUnfreeApps = [
    "1password"
    "spotify"
  ];
  environment.systemPackages = with pkgs; [
    spotify
  ];

  programs._1password-gui.enable = true;

  users.users.surma = {
    isNormalUser = true;
    description = "Surma";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.surma =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        ../home-manager/base.nix
        ../home-manager/dev.nix
        ../home-manager/nixdev.nix
        ../home-manager/linux.nix
        ../home-manager/graphical.nix
        ../home-manager/workstation.nix
        ../home-manager/wezterm.nix
        ../home-manager/hyprland.nix
        ../home-manager/waybar.nix

        ../home-manager/unfree-apps.nix
      ];

      config = {
        allowedUnfreeApps = [ "slack" ];

        home.packages = (
          with pkgs;
          [
            signal-desktop
            telegram-desktop
            slack
          ]
        );

        home.stateVersion = "24.05";

        home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";

        programs.wezterm.frontend = "OpenGL";
        programs.wezterm.theme = "dark";
        programs.wezterm.window-decorations = null;
        programs.waybar.enable = true;
        wayland.windowManager.hyprland = {
          enable = true;
          commands = [
            {
              variable = "terminal";
              package = pkgs.wezterm;
            }
            {
              variable = "lockScreen";
              package = pkgs.hyprlock;
            }
            rec {
              variable = "fileManager";
              package = pkgs.kdePackages.dolphin;
              bin = "${package}/bin/dolphin";
            }
            {
              variable = "appMenu";
              package = pkgs.wofi;
              args = [
                "--show"
                "drun"
              ];
            }
          ];
          execShortcuts = [
            {
              key = "T";
              command = "$terminal";
            }
            {
              key = "L";
              extraMods = "SHIFT";
              command = "$lockScreen";
            }
            {
              key = "F";
              command = "$fileManager";
            }
            {
              key = "Space";
              command = "$appMenu";
            }
          ];
        };
      };
    };

  programs.firefox.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
