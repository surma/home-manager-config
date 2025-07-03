{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{
  home.packages = with pkgs; [ pavucontrol ];
  programs.waybar = {
    settings.mainBar = import ../configs/waybar/default.nix;
    style = lib.readFile ../configs/waybar/style.css;
  };
}
