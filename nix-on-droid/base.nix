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

  user.shell = "${pkgs.zsh}/bin/zsh";

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
