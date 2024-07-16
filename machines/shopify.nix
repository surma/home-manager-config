{ pkgs, baseConfig, ... }:
{
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  programs.git.extraConfig.core = {
    untrackedCache = true;
    fsmonitor = true;
    fsmonitorhookversion = 2;
  };
}
