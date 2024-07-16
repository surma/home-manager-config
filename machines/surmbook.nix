{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  home.packages = final.baseConfig.home.packages ++ [
    pkgs.arc-browser
    pkgs.telegram-desktop
    # pkgs.davinci-resolve
  ];

  programs.zsh.shellAliases = {
    hms = "home-manager switch -A surmbook";
  };
}
