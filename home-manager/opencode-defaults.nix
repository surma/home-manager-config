{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./opencode.nix
    ./fetch-mcp.nix
    ./browser-mcp.nix
    ./mcp-nixos.nix
  ];

  programs.fetch-mcp.enable = true;
  programs.browser-mcp.enable = true;
  programs.mcp-nixos.enable = true;
  programs.opencode = {
    enable = true;
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
}
