{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;
  package = callPackage (import ../extra-pkgs/fetch-mcp) { };
in
with lib;
{
  options = {
    programs.fetch-mcp = {
      enable = mkEnableOption "";
      package = mkOption {
        type = types.package;
        default = package;
      };
    };
  };
  config =
    let
      inherit (config.programs) fetch-mcp;
    in
    mkIf fetch-mcp.enable {
      home.packages = [ fetch-mcp.package ];
    };
}
