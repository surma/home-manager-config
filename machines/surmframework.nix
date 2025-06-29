{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./surmframework-hardware.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
    inputs.home-manager.nixosModules.home-manager
    ../nixos/base.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "surmframework"; # Define your hostname.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
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
      ];

      config = {
        home.packages = (
          with pkgs;
          [
          ]
        );

        home.stateVersion = "24.05";

        home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";

        programs.wezterm.frontend = "OpenGL";
        programs.wezterm.theme = "dark";
        programs.wezterm.window-decorations = null;
        programs.waybar.enable = true;
        wayland.windowManager.hyprland.enable = true;
        wayland.windowManager.hyprland.commands = [
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
        wayland.windowManager.hyprland.execShortcuts = [
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

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    wireplumber
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
