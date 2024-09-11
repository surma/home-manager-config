args@{ pkgs, lib, ... }:
let
  overlay =
    final: prev:
    lib.recursiveUpdate prev {

      home.packages = prev.home.packages ++ (with pkgs; [ google-cloud-sdk ]);

      programs.git.extraConfig = {
        # core = {
        #   untrackedCache = true;
        #   fsmonitor = true;
        #   fsmonitorhookversion = 2;
        # };
        include = {
          path = "${final.home.homeDirectory}/.config/dev/gitconfig";
        };
      };

      programs.zsh = {
        initExtra =
          prev.programs.zsh.initExtra
          + ''
            [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
            [ -f /opt/dev/sh/chruby/chruby.sh ] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }
            [ -x /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)
          '';
        shellAliases = {
          hms = "home-manager switch -A shopify";
        };
      };
    };
  helpers = import ../helpers.nix;
in
helpers.applyOverlays [
  ../layers/base.nix
  ../layers/graphical.nix
  ../layers/workstation.nix
  ../layers/macos.nix
  overlay
] args
