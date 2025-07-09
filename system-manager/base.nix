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
    # TODO: ?
    nix.enable = mkEnableOption "";

    networking.hostName = mkOption {
      type = types.str;
    };
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
        "zprofile".text = ''
          emulate sh -c "source /etc/profile"
        '';
        "hostname".text = config.networking.hostName;
        "hosts".text = ''
          127.0.0.1	localhost
          ::1		localhost ip6-localhost ip6-loopback
          ff02::1		ip6-allnodes
          ff02::2		ip6-allrouters

          127.0.1.1	${config.networking.hostName}
        '';
      };
    };

    system-graphics.enable = true;

    systemd.services = {
    };
  };
}
