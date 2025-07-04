{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{
  imports = [
    ./default-config.nix
  ];

  options = {
    programs.opencode = {
      enable = mkEnableOption "";
      package = mkOption {
        type = types.package;
        default = pkgs.callPackage (import ../../extra-pkgs/opencode) { };
      };
      extraConfig = mkOption {
        type = types.attrs;
        default = { };
      };
      mcps = mkOption {
        type = types.attrsOf types.attrs;
        default = { };
      };
    };
  };
  config =
    let
      inherit (config.programs) opencode;
      baseConfig = {
        "$schema" = "https://opencode.ai/config.json";
      };
      fullConfig =
        baseConfig
        // {
          mcp = opencode.mcps;
        }
        // opencode.extraConfig;
    in
    mkIf opencode.enable {
      xdg.configFile."opencode/config.json".text = builtins.toJSON fullConfig;
      home.packages = [ opencode.package ];
    };
}
