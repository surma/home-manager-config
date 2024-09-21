{
  pkgs,
  lib,
  home-manager,
  ...
}:
final: prev:
let
  inherit (pkgs) system;
  hm = home-manager.packages.${system};
in
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ ];

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
      hm
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
  };
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        identityFile = "${final.home.homeDirectory}/.secrets/id_rsa";
      };
    };
  };
}
