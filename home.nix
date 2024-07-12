{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "obsidian"
      "arc-browser"
    ];

  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.fira-code
    pkgs.obsidian
    pkgs.gitui
    pkgs.arc-browser
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
  };
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    
  };
  programs.ssh = { };
  programs.gpg = { };
}
