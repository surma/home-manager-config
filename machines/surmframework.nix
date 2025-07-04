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

    ../common/signal
    ../common/obs

    ../nixos/obs-virtual-camera-fix.nix
    ../nixos/framework-suspend-fix.nix

    ../nixos/shopify-cloudflare-warp.nix
    ../nixos/_1password-wrapper.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  services.keyd = {
    enable = true;
    keyboards.default = {
      settings = {
        main = {
          capslock = "overload(meh, escape)";
        };
        "meh:C-A-M" = { };
      };
    };
  };
  services.libinput.touchpad.disableWhileTyping = true;

  networking.hostName = "surmframework"; # Define your hostname.
  allowedUnfreeApps = [
    "1password"
    "1password-cli"
  ];
  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    keyd
    hyprlock
    tailscale
    pavucontrol
    hyprsunset
  ];

  services.tailscale.enable = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "surma" ];
  programs.obs.enable = true;
  programs.obs.virtualCameraFix = true;
  programs.firefox.enable = true;
  programs.signal.enable = true;

  security.polkit.enable = true;
  security.pam.services.hyprlock = { };

  users.users.surma = {
    isNormalUser = true;
    description = "Surma";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "video"
      "audio"
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
        ../home-manager/gamedev.nix
        ../home-manager/nixdev.nix
        ../home-manager/linux.nix
        ../home-manager/graphical.nix
        ../home-manager/workstation.nix
        ../home-manager/experiments.nix
        ../home-manager/opencode-defaults.nix

        ../home-manager/hyprland
        ../home-manager/hyprsunset
        ../home-manager/syncthing
        ../home-manager/waybar
        ../home-manager/spotify.nix

        ../home-manager/unfree-apps.nix
        ../home-manager/webapps.nix
        ../home-manager/screenshot.nix
      ];

      config = {
        allowedUnfreeApps = [
          "slack"
          "discord"
          "spotify"
        ];

        home.packages = (
          with pkgs;
          [
            discord
            telegram-desktop
            slack
            nodejs_24
            chromium
            kdePackages.dolphin
            vlc
          ]
        );

        gtk = {
          enable = true;
          iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };
        };

        home.stateVersion = "24.05";

        home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";

        programs.spotify.enable = true;
        programs.whatsapp.enable = true;
        programs.squoosh.enable = true;
        programs.geforce-now.enable = true;
        programs.xbox-remote-play.enable = true;

        programs.wezterm.enable = true;
        programs.wezterm.frontend = "OpenGL";
        programs.wezterm.theme = "dark";
        programs.wezterm.fontSize = 10;
        programs.wezterm.window-decorations = null;
        defaultConfigs.wezterm.enable = true;

        programs.zellij.wl-clipboard.enable = true;

        services.syncthing.enable = true;
        defaultConfigs.syncthing.enable = true;

        wayland.windowManager.hyprland.enable = true;
        defaultConfigs.hyprland.enable = true;
        programs.waybar.enable = true;
        defaultConfigs.waybar.enable = true;
        programs.hyprsunset.enable = true;

        services.blueman-applet.enable = true;
        services.dunst.enable = true;
      };
    };

  services.fprintd.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
