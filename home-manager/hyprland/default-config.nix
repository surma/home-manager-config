{
  pkgs,
  config,
  lib,
  ...
}:
let
  disabledWorkspaces = "QWF" |> lib.stringToCharacters;
  numberWorkspaces =
    "123456789"
    |> lib.stringToCharacters
    |> lib.imap (
      i: key: {
        inherit key;
        idx = i - 1;
      }
    );

  letterWorkspaces =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    |> lib.stringToCharacters
    |> lib.imap (
      i: key: {
        inherit key;
        idx = i + 9;
      }
    );

  workspaceBindings =
    (numberWorkspaces ++ letterWorkspaces)
    |> lib.filter ({ key, ... }: !lib.elem key disabledWorkspaces)
    |> lib.map (
      { idx, key }:
      [
        {
          key = "$meh, ${key}";
          action.activateWorkspace = idx;
        }
        {
          key = "$meh SHIFT, ${key}";
          action.moveToWorkspace = idx;
        }
      ]
    )
    |> lib.flatten;

in
with lib;
{
  options = {
    defaultConfigs.hyprland = {
      enable = mkEnableOption "";
    };
  };
  config = {
    wayland.windowManager.hyprland = mkIf (config.defaultConfigs.hyprland.enable) {
      header = ''
        $meh = SUPER ALT CTRL
      '';
      bindings = workspaceBindings ++ [
        {
          key = "$meh SHIFT, W";
          action.text = "killactive";
        }
        {
          key = "$meh SHIFT, Q";
          action.text = "exit";
        }
        {
          key = "$meh, left";
          action.moveFocus = "left";
        }
        {
          key = "$meh, right";
          action.moveFocus = "right";
        }
        {
          key = "$meh, up";
          action.moveFocus = "up";
        }
        {
          key = "$meh, down";
          action.moveFocus = "down";
        }
        {
          key = "$meh, return";
          action.layoutMsg = "swapwithmaster";
        }
        {
          key = "$meh, minus";
          action.layoutMsg = "mfact -0.01";
        }
        {
          key = "$meh, equal";
          action.layoutMsg = "mfact +0.01";
        }
        {
          key = "$meh SHIFT, F";
          action.toggleFloating = true;
        }
        {
          key = "$meh, grave";
          action.text = "togglespecialworkspace, magic";
        }
        {
          key = "$meh SHIFT, grave";
          action.moveToWorkspace = "special:magic";
        }
        {
          key = "SUPER, space";
          action.exec = "${pkgs.wofi}/bin/wofi --show drun";
        }
        {
          key = "$meh, period";
          action.text = "movecurrentworkspacetomonitor, d";
        }
        {
          key = "$meh, comma";
          action.text = "movecurrentworkspacetomonitor, u";
        }
        {
          key = ",XF86AudioRaiseVolume";
          action.exec = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
          flags.e = true;
          flags.l = true;
        }
        {
          key = ",XF86AudioLowerVolume";
          action.exec = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          flags.e = true;
          flags.l = true;
        }
        # bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        # bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        # bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        # bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        # bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
        # bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

        # bindl = , XF86AudioNext, exec, playerctl next
        # bindl = , XF86AudioPause, exec, playerctl play-pause
        # bindl = , XF86AudioPlay, exec, playerctl play-pause
        # bindl = , XF86AudioPrev, exec, playerctl previous
      ];
    };
  };
}
