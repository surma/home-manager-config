{
  pkgs,
  config,
  lib,
  ...
}:
let
  extraLib = import ../../lib/default.nix;
  inherit (extraLib) mkMultiSystemModule;

  mod = mkMultiSystemModule "signal" rec {
    nix-darwin = {
      homebrew.casks = lib.optionals config.programs.signal.enable [ "signal" ];
    };
    nixos = {
      environment.systemPackages = lib.optionals config.programs.signal.enable [ pkgs.signal-desktop ];
    };
    home-manager = {
      home.systemPackages = lib.optionals config.programs.signal.enable [ pkgs.signal-desktop ];
    };
    system-manager = nixos;
  };
in
with lib;
{
  imports = [ mod ];
  options = {
    programs.signal.enable = mkEnableOption "";
  };
}
