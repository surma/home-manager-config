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

    ../nixos/obs.nix

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
  ];

  services.tailscale.enable = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "surma" ];
  programs.obs.enable = true;

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
        programs.wezterm.frontend = "OpenGL";
        programs.whatsapp.enable = true;
        programs.squoosh.enable = true;
        programs.geforce-now.enable = true;
        programs.xbox-remote-play.enable = true;
        programs.wezterm.theme = "dark";
        programs.wezterm.window-decorations = null;
        programs.waybar.enable = true;
        programs.zellij.wl-clipboard.enable = true;

        services.syncthing = {
          enable = true;
          settings = {
            devices = {
              surmcluster = {
                id = "CJT6SJ3-YD5KOXR-WRLN3GM-D5ALFHQ-7M6ZWSG-4MNKWG3-T525QU4-M77GYA3";
                addresses = [
                  "tcp://10.0.0.2:22000"
                  "tcp://sync.surmcluster.surmnet.surma.link:22000"
                ];
              };
            };
            folders = {
              "/home/surma/sync/scratch" = {
                id = "hbza9-iimbx";
                devices = [ "surmcluster" ];
              };
            };
          };
          tray.enable = true;
        };

        wayland.windowManager.hyprland = {
          enable = true;
          header = ''
            $meh = SUPER ALT CTRL
          '';
          bindings = [
            {
              key = "$meh SHIFT, W";
              action.text = "killactive";
            }
            {
              key = "$meh SHIFT, Q";
              action.text = "exit";
            }
            {
              key = "$meh, 0";
              action.activateWorkspace = 10;
            }
            {
              key = "$meh, 1";
              action.activateWorkspace = 1;
            }
            {
              key = "$meh, left";
              action.moveFocus = "left";
            }
            {
              key = "$meh, right";
              action.moveFocus = "right";
            }
            {
              key = "$meh, up";
              action.moveFocus = "up";
            }
            {
              key = "$meh, down";
              action.moveFocus = "down";
            }
            {
              key = "$meh SHIFT, 1";
              action.moveToWorkspace = 1;
            }
            {
              key = "$meh, return";
              action.layoutMsg = "swapwithmaster";
            }
            {
              key = "$meh, minus";
              action.layoutMsg = "mfact -0.01";
            }
            {
              key = "$meh, equal";
              action.layoutMsg = "mfact +0.01";
            }
            {
              key = "$meh SHIFT, F";
              action.toggleFloating = true;
            }
            {
              key = "$meh, grave";
              action.text = "togglespecialworkspace, magic";
            }
            {
              key = "$meh SHIFT, grave";
              action.moveToWorkspace = "special:magic";
            }
            {
              key = "SUPER, space";
              action.exec = "${pkgs.wofi}/bin/wofi --show drun";
            }
            {
              key = "$meh, period";
              action.text = "movecurrentworkspacetomonitor, d";
            }
            {
              key = "$meh, comma";
              action.text = "movecurrentworkspacetomonitor, u";
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
