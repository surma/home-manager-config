{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;
  allAllowedUnfreePackages = lib.lists.flatten (
    lib.lists.map (a: lib.attrsets.attrNames a) (lib.attrsets.attrValues config.allowUnfree)
  );
in
{
  config = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: lib.lists.elem (lib.getName pkg) allAllowedUnfreePackages;
    home.stateVersion = "24.05";
    home.packages =
      with pkgs;
      [
        age
        # barrier
        dprint
        git
        gitui
        git-lfs
        htop
        jq
        nix-index
        openssh
        rsync
        tig
        tree
        pinentry-curses
      ]
      ++ [
        (callPackage (import ../scripts) { })
        (callPackage (import ../secrets) { })
      ];

    home.file = {
      ".npmrc".source = ../configs/npmrc;
      ".gnupg/gpg-agent.conf".text = ''
        pinentry-program ${pkgs.pinentry-curses}/bin/pinentry
      '';
    };
    xdg.configFile = {
      "dump/config.json".text = builtins.toJSON { server = "http://10.0.0.2:8081"; };
      "nix/nix.conf".text = "extra-experimental-features = flakes nix-command";
    };

    home.sessionVariables = {
      EDITOR = "hx";
    };

    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "Surma";
      userEmail = "surma@surma.dev";
      signing = {
        key = "0x0F58C405";
        signByDefault = true;
      };
      diff-so-fancy = {
        enable = true;
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    programs.bat = {
      enable = true;
    };

    programs.autojump = {
      enable = true;
    };

    programs.eza = {
      enable = true;
      icons = true;
      git = true;
    };

    programs.helix = import ../configs/helix.nix;

    programs.jq.enable = true;
    # programs.obs-studio.enable = true;
    programs.ripgrep.enable = true;
    programs.starship = {
      enable = true;
    };
    programs.zsh = import ../configs/zsh.nix;
    programs.zellij = {
      enable = true;
      settings = {
        pane_frames = false;
        session_serialization = false;

        theme = "gruvbox";
        themes = {
          gruvbox = {
            fg = "#D5C4A1";
            bg = "#282828";
            black = "#3C3836";
            red = "#CC241D";
            green = "#98971A";
            yellow = "#D79921";
            blue = "#3C8588";
            magenta = "#B16286";
            cyan = "#689D6A";
            white = "#FBF1C7";
            orange = "#D65D0E";
          };
        };
      };
    };
    programs.ssh = {
      enable = true;
      forwardAgent = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "*" = {
          identityFile = "${config.home.homeDirectory}/.secrets/id_rsa";
        };
      };
    };
  };
}
