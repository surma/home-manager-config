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

    ../nixos/framework-suspend-fix.nix
    ../nixos/shopify-cloudflare-warp.nix
    ../nixos/_1password-wrapper.nix
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.kernelModules = [
    "v4l2loopback"
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

  networking.hostName = "surmframework"; # Define your hostname.
  allowedUnfreeApps = [
    "1password"
    "1password-cli"
  ];
  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    keyd
    hyprlock
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "surma" ];

  security.polkit.enable = true;
  security.pam.services.hyprlock = { };

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
        ../home-manager/gamedev.nix
        ../home-manager/nixdev.nix
        ../home-manager/linux.nix
        ../home-manager/graphical.nix
        ../home-manager/workstation.nix
        ../home-manager/experiments.nix
        ../home-manager/opencode-defaults.nix

        ../home-manager/wezterm.nix
        ../home-manager/hyprland.nix
        ../home-manager/waybar.nix
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
            signal-desktop
            discord
            telegram-desktop
            slack
            nodejs_24
            chromium
            obs-studio
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
        programs.wezterm.frontend = "OpenGL";
        programs.whatsapp.enable = true;
        programs.squoosh.enable = true;
        programs.geforce-now.enable = true;
        programs.xbox-remote-play.enable = true;
        programs.wezterm.theme = "dark";
        programs.wezterm.window-decorations = null;
        programs.waybar.enable = true;
        programs.zellij.wl-clipboard.enable = true;
        wayland.windowManager.hyprland = {
          enable = true;
          mainMod = "SUPER ALT CTRL";
          commands = [
            #   {
            #     variable = "terminal";
            #     package = pkgs.wezterm;
            #   }
            #   {
            #     variable = "lockScreen";
            #     package = pkgs.hyprlock;
            #   }
            #   rec {
            #     variable = "fileManager";
            #     package = pkgs.kdePackages.dolphin;
            #     bin = "${package}/bin/dolphin";
            #   }
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
            #   {
            #     key = "T";
            #     command = "$terminal";
            #   }
            #   {
            #     key = "L";
            #     extraMods = "SHIFT";
            #     command = "$lockScreen";
            #   }
            #   {
            #     key = "F";
            #     command = "$fileManager";
            #   }
            {
              key = "Space";
              command = "$appMenu";
            }
          ];
        };
        services.blueman-applet.enable = true;
        services.dunst.enable = true;
      };
    };

  programs.firefox.enable = true;
  services.fprintd.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
