{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.packages = with pkgs; [
    zsh
    helix
    git

  ];

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  home-manager = {
    config = ../modules/base.nix;
    # backupFileExtension = "hm-bak";
    # useGlobalPkgs = true;
  };
}
