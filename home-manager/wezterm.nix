{
  pkgs,
  config,
  lib,
  ...
}:
let
  package = pkgs.callPackage (import ../extra-pkgs/wezterm) { };
in
with lib;
{

  options = {
    programs.wezterm.frontend = mkOption {
      type =
        with types;
        enum [
          "WebGpu"
          "OpenGL"
        ];
      default = "WebGpu";
    };
  };
  config = {
    programs.wezterm = {
      package = mkDefault package;
      extraConfig = ''
        local light_scheme = 'Gruvbox (Gogh)'
        local dark_scheme = 'Gruvbox Dark (Gogh)'

        function scheme_for_appearance(appearance)
          if appearance:find 'Dark' then
            return  'Gruvbox Dark (Gogh)'
          else
            return 'Gruvbox (Gogh)'
          end
        end

        wezterm.on('window-config-reloaded', function(window, pane)
          local overrides = window:get_config_overrides() or {}
          local appearance = window:get_appearance()
          local scheme = scheme_for_appearance(appearance)
          if overrides.color_scheme ~= scheme then
            overrides.color_scheme = scheme
            window:set_config_overrides(overrides)
          end
        end)

        local config = wezterm.config_builder()
        config.front_end = "${config.programs.wezterm.frontend}"
        config.send_composed_key_when_left_alt_is_pressed = true
        config.enable_tab_bar = false
        config.window_padding = {
          top = "0.5cell",
          bottom = "1.5cell",
          left = "1cell",
          right = "1cell",
        }
        config.color_scheme = 'Gruvbox Dark (Gogh)'
        config.font = wezterm.font 'Fira Code'
        config.font_size = 12.0
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
  };
}
