{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    args:
    let
      loadConfig = import ./load-config.nix args;
      loadDarwin = import ./load-darwin.nix args;
    in
    {
      darwinConfigurations = {
        surmbook = loadDarwin {
          system = "aarch64-darwin";
          darwinModules = [ ./darwin/base.nix ];
          hmModules = [
            ./modules/base.nix
            ./modules/graphical.nix
            ./modules/workstation.nix
            ./modules/physical.nix
            ./modules/macos.nix
            ./machines/surmbook.nix
          ];
        };
      };

      # surmbook = loadDarwin {
      #   system = "aarch64-darwin";
      #   hmModules = [
      #     ./modules/base.nix
      #     ./modules/graphical.nix
      #     ./modules/workstation.nix
      #     ./modules/physical.nix
      #     ./modules/macos.nix
      #     ./machines/surmbook.nix
      #   ];
      #   darwinModules = [
      #     {
      #       system.stateVersion = 5;
      #        services.nix-daemon.enable = true;
      #           nix.settings.experimental-features = "nix-command flakes";
      #               nixpkgs.hostPlatform = "aarch64-darwin";

      #       users.users.surma = {
      #         name = "surma";
      #         home = "/Users/surma";
      #       };
      #     }
      #   ];
      # };
      # };
      homeConfigurations = {
        surmbook = loadConfig "aarch64-darwin" [
          # surmbook = ({...}: {imports = [
          ./modules/base.nix
          ./modules/graphical.nix
          ./modules/workstation.nix
          ./modules/physical.nix
          ./modules/macos.nix
          ./machines/surmbook.nix
        ];
        # });
        shopisurm = loadConfig "aarch64-darwin" [
          ./modules/base.nix
          ./modules/graphical.nix
          ./modules/workstation.nix
          ./modules/macos.nix
          ./modules/physical.nix
          ./machines/shopisurm.nix
        ];
        surmserver = loadConfig "aarch64-linux" [
          ./modules/base.nix
          ./modules/linux.nix
          ./modules/workstation.nix
          ./machines/surmserver.nix
        ];
        generic-linux = loadConfig "aarch64-linux" [
          ./modules/base.nix
          ./modules/linux.nix
          ./modules/workstation.nix
          ./machines/generic-linux.nix
        ];
        surmpi = loadConfig "aarch64-linux" [
          ./modules/base.nix
          ./modules/linux.nix
          ./modules/workstation.nix
          ./machines/surmpi.nix
        ];
        spin = loadConfig "x86_64-linux" [
          ./modules/base.nix
          ./modules/linux.nix
          ./modules/workstation.nix
          ./machines/spin.nix
        ];
        pixos = loadConfig "aarch64-linux" [
          ./modules/base.nix
          ./modules/linux.nix
          ./modules/workstation.nix
          ./machines/pixos.nix
        ];
      };
    };
}
