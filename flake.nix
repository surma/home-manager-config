{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    nixospkgs.url = "github:nixos/nixpkgs/nixos-25.05";
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
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/98236410ea0fe204d0447149537a924fb71a6d4f";
      inputs.nixpkgs.follows = "nixopgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    args@{
      flake-utils,
      nixpkgs,
      nixospkgs,
      system-manager,
      nix-system-graphics,
      nixos-hardware,
      ...
    }:
    let
      loadLinux = import ./load-linux.nix args;
      loadDarwin = import ./load-darwin.nix args;
      loadAndroid = import ./load-android.nix args;
    in
    rec {
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
          # homeConfiguration.surmframework.
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

      nixosConfigurations = {
        framework = nixospkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/framework.nix
          ];
        };
      };
    }
    // (flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        jupyterDeno = nixpkgs.legacyPackages.${system}.callPackage ./extra-pkgs/jupyter { };
      };
    }));
}
