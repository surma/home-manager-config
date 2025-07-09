{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  imports = [
    ../darwin/base.nix

    ../common/obs
    ../common/obsidian
  ];

  system.stateVersion = 5;

  nix.extraOptions = ''
    !include nix.conf.d/shopify.conf
  '';

  programs.obs.enable = true;
  programs.obsidian.enable = true;

  home-manager.users.${config.system.primaryUser} =
    { config, ... }:
    {
      imports = [
        ../common/spotify

        ../home-manager/opencode
        ../home-manager/claude-code

        ../home-manager/base.nix
        ../home-manager/graphical.nix
        ../home-manager/workstation.nix
        ../home-manager/physical.nix
        ../home-manager/macos.nix
        ../home-manager/cloud.nix
        ../home-manager/nixdev.nix
        ../home-manager/javascript.nix
        ../home-manager/dev.nix
        ../home-manager/experiments.nix
        ../home-manager/unfree-apps.nix
      ];

      home.stateVersion = "24.05";

      home.sessionVariables.FLAKE_CONFIG_URI = "${config.home.homeDirectory}/src/github.com/surma/nixenv#shopisurm";

      allowedUnfreeApps = [
        "spotify"
      ];

      home.packages =
        (with pkgs; [
          # graphite-cli
          keycastr
          (python3.withPackages (ps: [
            ps.distutils
          ]))
        ])
        ++ [
          (callPackage (import ../extra-pkgs/ollama) { })
        ];

      programs.opencode.enable = true;
      defaultConfigs.opencode.enable = true;
      programs.claude-code.enable = true;
      defaultConfigs.claude-code.enable = true;

      customScripts.hms.enable = true;
      customScripts.denix.enable = true;
      customScripts.ghclone.enable = true;
      customScripts.wallpaper-shuffle.enable = true;
      customScripts.wallpaper-shuffle.asDesktopItem = true;
      customScripts.get-shopify-key.enable = true;
      customScripts.update-shopify-key.enable = true;
      customScripts.update-shopify-key.asDesktopItem = true;

      programs.spotify.enable = true;
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
        initContent = ''
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
