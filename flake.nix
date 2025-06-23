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
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    args@{ flake-utils, nixpkgs, ... }:
    let
      loadLinux = import ./load-linux.nix args;
      loadDarwin = import ./load-darwin.nix args;
      loadAndroid = import ./load-android.nix args;

      callPackageForEachDefaultSystem =
        name: path:
        flake-utils.lib.eachDefaultSystem (system: {
          ${name} = nixpkgs.legacyPackages.${system}.callPackage (import path) { };
        });
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
