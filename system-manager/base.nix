{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = {
    nixpkgs.hostPlatform = "x86_64-linux";

    environment = {
      etc = {
        "nix/nix.conf".text = ''
          build-users-group = nixbld
          experimental-features = nix-command flakes pipe-operators
        '';
      };
      systemPackages = with pkgs; [
        helix
        git
      ];
    };

    system-graphics.enable = true;

    systemd.services = {
      # foo = {
      #   enable = true;
      #   serviceConfig = {
      #     Type = "oneshot";
      #     RemainAfterExit = true;
      #   };
      #   wantedBy = [ "system-manager.target" ];
      #   script = ''
      #     ${lib.getBin pkgs.hello}/bin/hello
      #     echo "We launched the rockets!"
      #   '';
      # };
    };

    build = {
      scripts = {
        lol = pkgs.writeShellScriptBin "lol" ''
          echo hi
        '';
      };
    };
  };
}
