{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{

  options.allowUnfree.macos = {
    "graphite-cli" = true;
  };

  config = {

    home.packages =
      (with pkgs; [
        google-cloud-sdk
        opentofu
        graphite-cli
        keycastr
        (python3.withPackages (ps: [
          ps.distutils
        ]))
      ])
      ++ [
        # (callPackage (import ../extra-pkgs/vfkit) { })
      ];

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
      maintenance = {
        repo = "${config.home.homeDirectory}/world/git";
      };
    };

    programs.zsh = {
      initExtra = ''
        [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
        [[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }
        [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

        export NIX_PATH=world=$HOME/world/trees/root/src/.meta/substrate/nix
        export PATH=$HOME/.local/state/nix/profiles/wb/bin:$PATH

        # Added by //areas/tools/world-up
        [[ -x ~/.local/state/nix/profiles/world/init ]] && eval "$(~/.local/state/nix/profiles/world/init zsh)"
      '';
    };
    programs.ssh = {
      includes = [
        "~/.spin/ssh/include"
        "~/.config/spin/ssh/include"
      ];
    };
  };
}
