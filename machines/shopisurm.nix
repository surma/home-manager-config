{ config, pkgs, ... }:
{
  config = {

    home.packages = [
      google-cloud-sdk
      opentofu
      podman
      podman-compose
    ] ++ [ (callPackage (import ../extra-pkgs/vfkit) { }) ];

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#shopisurm";

    programs.git.extraConfig = {
      # core = {
      #   untrackedCache = true;
      #   fsmonitor = true;
      #   fsmonitorhookversion = 2;
      # };
      include = {
        path = "${config.home.homeDirectory}/.config/dev/gitconfig";
      };
    };

    programs.zsh = {
      initExtra = ''
        [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
        [ -f /opt/dev/sh/chruby/chruby.sh ] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }
        [ -x /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)
      '';
    };
  };
}
