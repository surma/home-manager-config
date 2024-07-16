{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  programs.git.extraConfig.core = {
    untrackedCache = true;
    fsmonitor = true;
    fsmonitorhookversion = 2;
  };

  programs.zsh = {
    initExtra =
      prev.programs.zsh.initExtra
      + ''
        [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
      '';
    shellAliases = {
      hms = "home-manager switch -A shopify";
    };
  };
}
