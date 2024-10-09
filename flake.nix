{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    args:
    let
      loadConfig = import ./load-config.nix args;
    in
    {
      homeConfigurations = {
        surmbook = loadConfig "aarch64-darwin" [
          ./modules/base.nix
          ./modules/graphical.nix
          ./modules/workstation.nix
          ./modules/physical.nix
          ./modules/macos.nix
          ./machines/surmbook.nix
        ];
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
