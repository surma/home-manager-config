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

  environment.etc."dropbear/authorized_keys".text = ''
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBpQAnBfVN7zfxxPQpIl8ZKII6cKVaHdBMnwi2aH5uApr313bD+3fi9SXkV8E+5X+MwQIaXs+fzEDifrDCsGhegC9Nedt0wGwcV84mjqXEy/8hzsMkO1bKX7i6i2wUaWasfG/kyC8/eJGoGmhZ27Wq7tPlzBRUgp9fzjXtpMlUXoLKnc7gU1soKdtEfBSZeh0pyUL8DTDVKvnzfAF0yKqV2qjyymwIf6LTQ3gWaHCY6neM/ROE0iGuFcYnCU9dEiyH59NBEiXvekA/mjPdJB9hMWgjcnuikj1A/iNiKkroMI3ky+GDiRomnRjnrTjSIvmhG6WuXb1gTspnZbyDjj5r surma@surma-macbookpro.roam.corp.google.com
  '';

  # home-manager = {
  #   config = ../modules/base.nix;
  #   # backupFileExtension = "hm-bak";
  #   # useGlobalPkgs = true;
  # };
}
