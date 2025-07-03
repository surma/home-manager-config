{
  systemManager,
  pkgs,
  lib,
  ...
}:
let
  package = pkgs.obs-studio;
  configs = rec {
    nix-darwin = {
      homebrew.casks = [ "obs" ];
    };
    nixos = {
      environment.systemPackages = [ package ];
    };
    home-manager = {
      home.systemPackages = [ package ];
    };
    system-manager = nixos;
  };
in
with lib;
{
  options = {
    programs.signal = {
      enable = mkEnableOption "";
    };
  };
  config =
    if configs ? systemManager then
      configs.${systemManager}
    else
      throw "Unsupported system manager ${systemManager} for ${package.meta.name}";
}
