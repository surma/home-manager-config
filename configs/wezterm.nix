{
  callPackage,
}:
let
  package = callPackage (import ../extra-pkgs/wezterm) { };
in
{
  wezterm = {
    inherit package;

    enable = true;
    extraConfig = ''
      local config = wezterm.config_builder()
      config.send_composed_key_when_left_alt_is_pressed = true
      config.enable_tab_bar = false
      config.window_padding = {
        top = "0.5cell",
        bottom = "0.5cell",
        left = "1cell",
        right = "1cell",
      }
      config.front_end = "WebGpu"
      config.color_scheme = 'Gruvbox Dark (Gogh)'
      config.font = wezterm.font 'Fira Code'
      config.font_size = 14.0
      config.window_decorations = 'RESIZE'
      config.window_frame = {
        font = wezterm.font({ family = 'Fira Code', weight = 'Bold' }),
        font_size = 11,
      }


      config.keys = {
        {
          key = '-',
          mods = 'CTRL',
          action = wezterm.action.DisableDefaultAssignment,
        },
        {
          key = '=',
          mods = 'CTRL',
          action = wezterm.action.DisableDefaultAssignment,
        },
        {
          key = '0',
          mods = 'CTRL',
          action = wezterm.action.DisableDefaultAssignment,
        },
      }

      return config
    '';
  };
}
