{ pkgs, baseConfig, ... }:
{
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  home.packages = baseConfig.home.packages ++ [
    pkgs.arc-browser
    pkgs.telegram-desktop
    # pkgs.davinci-resolve
  ];

  programs.zsh.shellAliases = {
    hms = "home-manager switch -A surmbook";
  };
}
