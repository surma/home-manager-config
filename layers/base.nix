{ pkgs, lib, ... }:
final: prev:
let
  pkgs-unstable = import ../nixpkgs-unstable.nix { inherit pkgs; } { };
  fenix-repo = import ../fenix.nix { inherit pkgs; };
in
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
      "vscode"
    ];

  nixpkgs.overlays = [ (import "${fenix-repo}/overlay.nix") ];

  home.stateVersion = "24.05";

  home.packages =
    with pkgs;
    [
      age
      # barrier
      binaryen
      devenv
      dprint
      ffmpeg
      git
      gitui
      git-lfs
      htop
      jq
      just
      nil
      nixfmt-rfc-style
      nix-index
      nodejs_22
      podman
      podman-compose
      openssh
      rsync
      tig
      tree
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
    ++ [
      (import ../scripts { inherit pkgs; })
      (callPackage (import ../secrets) { })
      (callPackage (import ../extra-pkgs/vfkit.nix) { })
    ]
    ++ [ pkgs-unstable.ollama ];

  home.file = {
    ".npmrc".source = ../configs/npmrc;
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
  programs.yt-dlp.enable = true;
  programs.zsh = import ../configs/zsh.nix;
  programs.zellij = {
    enable = true;
  };
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        identityFile = "${final.home.homeDirectory}/.secrets/id_rsa";
        extraOptions = {
          "IdentityAgent" = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
        };
      };
    };
  };
}