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
  options.allowUnfree.macos = {
    "raycast" = true;
  };

  config = {
    home.username = lib.mkDefault "surma";
    home.homeDirectory = lib.mkDefault "/Users/surma";
    home.packages =
      (with pkgs; [
        raycast
      ])
      ++ [
        (callPackage (import ../extra-pkgs/hyperkey) { })
        (callPackage (import ../extra-pkgs/aerospace-bin) { })
      ];

    home.file.".config/aerospace/aerospace.toml".source = ../configs/aerospace.toml;

    home.file.".config/karabiner/karabiner.json" = {
      source = ../configs/karabiner.json;
    };

    home.sessionVariables = {
      # LIBRARY_PATH = ''${lib.makeLibraryPath [pkgs.iconv]}''${LIBRARY_PATH:+:$LIBRARY_PATH}'';
      CONFIG_MANAGER = "darwin-rebuild";
    };

    # Use 1password to unlock SSH key
    programs.ssh.matchBlocks."*".extraOptions = {
      "IdentityAgent" =
        ''"${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
    };

    programs.zsh = {
      initExtra = ''
        export PATH=$PATH:/run/current-system/sw/bin
      '';
    };
  };
}
