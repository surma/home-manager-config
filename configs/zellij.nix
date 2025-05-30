{
  callPackage,
  lib,
}:
let
  package = callPackage (import ../extra-pkgs/zellij) { };
in
{
  zellij = {
    inherit package;

    enable = true;
    settings = {
      pane_frames = false;
      session_serialization = false;
      show_startup_tips = false;

      theme = "gruvbox";
      themes = {
        gruvbox = {
          fg = "#D5C4A1";
          bg = "#282828";
          black = "#3C3836";
          red = "#CC241D";
          green = "#98971A";
          yellow = "#D79921";
          blue = "#3C8588";
          magenta = "#B16286";
          cyan = "#689D6A";
          white = "#FBF1C7";
          orange = "#D65D0E";
        };
      };

      keybinds = {
        unbind = [ "Ctrl q" ];
      };
    };
  };
}
