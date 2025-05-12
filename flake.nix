{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
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
      loadConfig = import ./load-config.nix args;
      loadDarwin = import ./load-darwin.nix args;
      loadDroid = import ./load-android.nix args;
    in
    {
      darwinConfigurations = {
        surmbook = loadDarwin {
          system = "aarch64-darwin";
          darwinModules = [
            ./darwin/base.nix
            ./darwin/surmbook.nix
          ];
          hmModules = [
            ./modules/base.nix
            ./modules/graphical.nix
            ./modules/workstation.nix
            ./modules/physical.nix
            ./modules/macos.nix
            ./machines/surmbook.nix
          ];
        };
        shopisurm = loadDarwin {
          system = "aarch64-darwin";
          darwinModules = [
            ./darwin/base.nix
            ./darwin/shopisurm.nix
          ];
          hmModules = [
            ./modules/base.nix
            ./modules/graphical.nix
            ./modules/workstation.nix
            ./modules/physical.nix
            ./modules/macos.nix
            ./machines/shopisurm.nix
          ];
        };
      };

      homeConfigurations = {
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

      nixOnDroidConfigurations.surmpixel = loadDroid {
        system = "aarch64-linux";
        droidModules = [
          ./nix-on-droid/base.nix
        ];
        hmModules = [
          ./modules/base.nix
          ./modules/android.nix
          ./machines/surmpixel.nix
        ];
      };
    };
}
