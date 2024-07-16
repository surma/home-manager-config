{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  programs.git.extraConfig.core = {
    untrackedCache = true;
    fsmonitor = true;
    fsmonitorhookversion = 2;
  };

  programs.zsh.shellAliases = {
    hms = "home-manager switch -A shopify";
  };
}
