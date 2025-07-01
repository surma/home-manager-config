{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;
in
{

  imports = [
    ./zellij.nix
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = "nix-command flakes pipe-operators";
  };
  home.packages =
    with pkgs;
    [
      age
      gawk
      htop
      btop
      mosh
      openssh
      rsync
      tig
      tree
      pinentry-curses
      chafa
      yazi
      fzf
      nushell
      zoxide
    ]
    ++ [ (callPackage (import ../extra-pkgs/dprint) { }) ]
    ++ [
      (callPackage (import ../scripts) { })
      (callPackage (import ../secrets) { })
    ];

  home.file = {
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

  programs.bat = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  programs.helix = import ../configs/helix.nix;

  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
  };
  programs.zsh = import ../configs/zsh.nix;
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

}
