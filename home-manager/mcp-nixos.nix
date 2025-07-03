{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;
  package = callPackage (import ../extra-pkgs/mcp-nixos) { };
in
with lib;
{
  options = {
    programs.mcp-nixos = {
      enable = mkEnableOption "";
      package = mkOption {
        type = types.package;
        default = package;
      };
    };
  };
  config =
    let
      inherit (config.programs) mcp-nixos;
    in
    mkIf mcp-nixos.enable {
      home.packages = [ mcp-nixos.package ];
    };
}
