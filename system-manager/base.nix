{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options = {
    nix.enable = mkEnableOption "";
  };
  config = {

    environment = {
      systemPackages = with pkgs; [
        helix
        git
      ];
      etc = {
        "nix/nix.conf".text = ''
          experimental-features = nix-command flakes pipe-operators
        '';
      };
    };

    system-graphics.enable = true;

    systemd.services = {
    };
  };
}
