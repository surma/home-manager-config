{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix-pkgs = {
      url = "github:nix-community/fenix";
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
        surmbook = loadConfig "aarch64-darwin" ./machines/surmbook.nix;
        shopisurm = loadConfig "aarch64-darwin" ./machines/shopisurm.nix;
        surmserver = loadConfig "aarch64-linux" ./machines/surmserver.nix;
        generic-linux = loadConfig "aarch64-linux" ./machines/generic-linux.nix;
        surmpi = loadConfig "aarch64-linux" ./machines/surmpi.nix;
      };
    };
}
