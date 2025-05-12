{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    args:
    let
      loadLinux = import ./load-linux.nix args;
      loadDarwin = import ./load-darwin.nix args;
      loadAndroid = import ./load-android.nix args;
    in
    {
      darwinConfigurations = {
        surmbook = loadDarwin {
          system = "aarch64-darwin";
          machine = ./machines/surmbook.nix;
        };
        shopisurm = loadDarwin {
          system = "aarch64-darwin";
          machine = ./machines/shopisurm.nix;
        };
      };

      homeConfigurations = {
        surmpi = loadLinux {
          system = "aarch64-linux";
          machine = ./machines/surmpi.nix;
        };
        # surmserver = loadLinux "aarch64-linux" [
        #   ./modules/base.nix
        #   ./modules/linux.nix
        #   ./modules/workstation.nix
        #   ./machines/surmserver.nix
        # ];
        # generic-linux = loadLinux "aarch64-linux" [
        #   ./modules/base.nix
        #   ./modules/linux.nix
        #   ./modules/workstation.nix
        #   ./machines/generic-linux.nix
        # ];
        # surmpi = loadLinux "aarch64-linux" [
        #   ./modules/base.nix
        #   ./modules/linux.nix
        #   ./modules/workstation.nix
        #   ./machines/surmpi.nix
        # ];
        # spin = loadLinux "x86_64-linux" [
        #   ./modules/base.nix
        #   ./modules/linux.nix
        #   ./modules/workstation.nix
        #   ./machines/spin.nix
        # ];
        # pixos = loadLinux "aarch64-linux" [
        #   ./modules/base.nix
        #   ./modules/linux.nix
        #   ./modules/workstation.nix
        #   ./machines/pixos.nix
        # ];
      };
      nixOnDroidConfigurations.generic-android = loadAndroid {
        droidModules = [
          ./nix-on-droid/base.nix
        ];
        hmModules = [
          ./modules/base.nix
          ./machines/surmpixel.nix
        ];
      };
    };
}
