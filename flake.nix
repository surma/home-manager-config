{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
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
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    args@{
      flake-utils,
      nixpkgs,
      system-manager,
      nix-system-graphics,
      ...
    }:
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

      systemConfigs = {
        surmframework = system-manager.lib.makeSystemConfig {
          modules = [
            nix-system-graphics.systemModules.default
            ./system-manager/base.nix
          ];
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
        generic-aarch64-linux = loadLinux {
          system = "aarch64-linux";
          machine = ./machines/generic-linux.nix;
        };
        surmframework = loadLinux {
          system = "x86_64-linux";
          machine = ./machines/surmframework.nix;
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

    }
    // (flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        jupyterDeno = nixpkgs.legacyPackages.${system}.callPackage ./extra-pkgs/jupyter { };
      };
    }));
}
