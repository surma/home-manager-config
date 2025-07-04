{
  pkgs,
  config,
  lib,
  ...
}:
let
  isEnabled = config.defaultConfigs.opencode.enable;
in
with lib;
{
  imports = [
    ../fetch-mcp.nix
    ../browser-mcp.nix
    ../mcp-nixos.nix
  ];

  options = {
    defaultConfigs.opencode.enable = mkEnableOption "";
  };

  config = {

    programs.fetch-mcp.enable = mkIf isEnabled true;
    programs.browser-mcp.enable = mkIf isEnabled true;
    programs.mcp-nixos.enable = mkIf isEnabled true;
    programs.opencode = {
      extraConfig = {
        provider = {
          litellm = {
            models = {
              "shopify:anthropic:claude-sonnet-4" = { };
              "shopify:google:gemini-2.5-pro-preview-05-06" = { };
            };
            npm = "@ai-sdk/openai-compatible";
            options = {
              baseURL = "http://litellm.surmcluster.10.0.0.2.nip.io";
            };
          };
        };

      };
      mcps = {
        fetch-mcp = {
          type = "local";
          command = [ "fetch-mcp" ];
          enabled = true;
        };
        browser-mcp = {
          type = "local";
          command = [ "browser-mcp" ];
          enabled = true;
        };
        mcp-nixos = {
          type = "local";
          command = [ "mcp-nixos" ];
          enabled = true;
        };
      };
    };
  };
}
