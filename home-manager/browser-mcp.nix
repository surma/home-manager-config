{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;
  package = callPackage (import ../extra-pkgs/browser-mcp) { };
in
with lib;
{
  options = {
    programs.browser-mcp = {
      enable = mkEnableOption "";
      package = mkOption {
        type = types.package;
        default = package;
      };
    };
  };
  config =
    let
      inherit (config.programs) browser-mcp;
    in
    mkIf browser-mcp.enable {
      home.packages = [ browser-mcp.package ];
    };
}
