{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (config.programs) claude-code;
  inherit (pkgs) writeShellScriptBin callPackage;

  package = callPackage (import ../../extra-pkgs/claude-code) { };

  mcpServerType = import ../../lib/module-types/mcp-server.nix lib;

  defaultClaudeJson =
    {
      hasCompletedOnboarding = true;
      # mcps = claude-code.mcps
    }
    |> builtins.toJSON
    |> builtins.toFile "dot-claude-json";

  wrapper = writeShellScriptBin "claude" ''
    export ANTHROPIC_BASE_URL="https://proxy.shopify.ai/vendors/anthropic-claude-code"
    # export ANTHROPIC_API_KEY=$(/opt/dev/bin/dev llm-gateway print-token --key)
    ${claude-code.package}/bin/claude "$@"
  '';
in
with lib;
{
  options = {
    programs.claude-code = {
      enable = mkEnableOption "";
      package = mkOption {
        type = types.package;
        default = package;
      };
      mcps = mkOption {
        type = types.attrsOf types.attrs;
        default = { };
      };
    };
  };
  config = mkIf claude-code.enable {
    home.activation.copyClaudeJson = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -f ~/.claude.json ]; then
        cp ${defaultClaudeJson} ~/.claude.json
        chmod 644 ~/.claude.json
      fi
    '';

    home.packages = [ wrapper ];
  };
}
