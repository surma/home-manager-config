{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  programs.git.extraConfig = {
    core = {
      untrackedCache = true;
      fsmonitor = true;
      fsmonitorhookversion = 2;
    };
    include = {
      path = "${final.home.homeDirectory}/.config/dev/gitconfig";
    };
  };

  programs.zsh = {
    initExtra =
      prev.programs.zsh.initExtra
      + ''
        [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
        [[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }
        [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
      '';
    shellAliases = {
      hms = "home-manager switch -A shopify";
    };
  };
}
