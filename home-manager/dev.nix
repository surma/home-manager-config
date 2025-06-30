{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      git
      gitui
      lazygit
      git-lfs
      tig
      nodejs_24.pkgs.typescript-language-server
    ]
    ++ [ (callPackage (import ../extra-pkgs/dprint) { }) ];

  home.file = {
    ".npmrc".source = ../configs/npmrc;
  };

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
}
