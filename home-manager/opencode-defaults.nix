{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.fetch-mcp.enable = true;
  programs.opencode = {
    enable = true;
    extraConfig = {
      provider = {
        litellm = {
          models = {
            "shopify:anthropic:claude-sonnet-4" = { };
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
    };
  };
}
