{ pkgs, lib, ... }:
rec {
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
      "arc-browser"
      "spotify"
      "raycast"
    ];

  imports = [ ./surmtest.nix ];

  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.jq
    pkgs.fira-code
    pkgs.obsidian
    pkgs.gitui
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.raycast
    pkgs.dprint
    pkgs.age
    pkgs.devenv
    pkgs.nodejs.pkgs.typescript-language-server
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;

    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/surma/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.home-manager.enable = true;
  # programs.surmtest.enable = true;

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

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = wezterm.config_builder()
      config.send_composed_key_when_left_alt_is_pressed = true
      -- config.color_scheme = 'Everforest Dark (Gogh)'
      -- config.color_scheme = 'Everforest Light (Gogh)'
      config.color_scheme = 'Gruvbox Dark (Gogh)'
      -- config.color_scheme = 'Everforest Light (Gogh)'
      config.font = wezterm.font 'Fira Code'
      config.font_size = 16.0
      config.hide_tab_bar_if_only_one_tab = true
      return config
    '';
  };

  programs.helix = import ./helix.nix;

  programs.jq.enable = true;
  # programs.obs-studio.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
  };
  programs.yt-dlp.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      ga = "git add";
      gc = "git commit -v";
      gca = "git commit -av";
      gd = "git diff -- . ':(exclude)*-lock.json' ':(exclude)*.lock'";
      gdc = "git diff --cached -- . ':(exclude)package-lock.json'";
      gs = "git status";
      gidiot = "git commit --amend --no-edit";
    };
    initExtra = ''
      # This is needed for gpg+pinentry to work
      export GPG_TTY=$(tty)
    '';
  };
  programs.zellij = {
    enable = true;
  };
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        identityFile = "${home.homeDirectory}/.sshkeys/id_rsa";
        extraOptions = {
          "IdentityAgent" = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
        };
      };
    };
  };
}