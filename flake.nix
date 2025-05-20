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
    amber-upstream = {
      url = "github:amber-lang/Amber";
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
        surmserver = loadLinux {
          system = "aarch64-linux";
          machine = ./machines/surmserver.nix;
        };
        generic-linux = loadLinux {
          system = "aarch64-linux";
          machine = ./machines/generic-linux.nix;
        };
      };

      nixOnDroidConfigurations = {
        generic-android = loadAndroid {
          system = "aarch64-linux";
          machine = ./machines/generic-android.nix;
        };
        surmpixel = loadAndroid {
          system = "aarch64-linux";
          machine = ./machines/surmpixel.nix;
        };
      };
    };
}
