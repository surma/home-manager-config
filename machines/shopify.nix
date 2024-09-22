args@{ pkgs, lib, ... }:
let
  applyOverlays = import ../apply-overlays.nix args;
  overlay =
    final: prev:
    lib.recursiveUpdate prev {

      home.packages =
        prev.home.packages
        ++ (with pkgs; [
          google-cloud-sdk
          opentofu
          podman
          podman-compose
        ]);

      home.sessionVariables.FLAKE_CONFIG_URI = "path:${final.home.homeDirectory}/.config/home-manager#shopisurm";

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
      };
    };
in
applyOverlays [
  ../layers/base.nix
  ../layers/graphical.nix
  ../layers/workstation.nix
  ../layers/macos.nix
  overlay
]
