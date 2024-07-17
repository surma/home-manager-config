{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  home.username = "surma";
  home.homeDirectory = "/Users/surma";

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    (prev.nixpkgs.config.allowUnfreePredicate pkg)
    || builtins.elem (lib.getName pkg) [
      "arc-browser"
      "vcv-rack"
    ];

  home.packages =
    prev.home.packages
    ++ (with pkgs; [
      arc-browser
      telegram-desktop
      # mgba
      # vcv-rack

      # pkgs.davinci-resolve
    ]);

  programs.zsh.shellAliases = {
    hms = "home-manager switch -A surmbook";
  };
}
