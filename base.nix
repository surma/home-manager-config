{ pkgs, lib, ... }:
final: {
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
      "raycast"
      "vscode"
    ];

  nixpkgs.overlays = [
    (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
  ];

  imports = [ ./surmtest.nix ];

  home.stateVersion = "24.05";

  home.packages =
    with pkgs;
    [
      age
      audacity
      # barrier
      binaryen
      devenv
      dprint
      ffmpeg
      fira-code
      git
      gitui
      git-lfs
      htop
      jq
      nil
      nixfmt-rfc-style
      nodejs_22
      obsidian
      ollama
      openssh
      raycast
      rsync
      tig
      tree
      vscode
      vlc-bin
      wabt
      wasmtime
      nodejs.pkgs.typescript-language-server
    ]
    ++ [
      (fenix.stable.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      fenix.targets.wasm32-unknown-unknown.stable.rust-std
      fenix.targets.wasm32-wasi.stable.rust-std
      rust-analyzer
    ]
    ++ [ (import ./scripts { inherit pkgs; }) ];

  home.file = {
    ".npmrc".source = ./configs/npmrc;
    # ".gradle/gradle.properties".text = "bla";
  };

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
        identityFile = "${final.home.homeDirectory}/.sshkeys/id_rsa";
        extraOptions = {
          "IdentityAgent" = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
        };
      };
    };
  };
}
