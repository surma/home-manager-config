{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{
  programs.waybar = {
    settings.mainBar = import ../configs/waybar/default.nix;
    style = lib.readFile ../configs/waybar/style.css;
  };
}
