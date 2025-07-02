{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  actionType = types.submodule {
    options = {
      activateWorkspace = mkOption {
        type = types.nullOr (
          types.oneOf [
            types.int
            types.str
          ]
        );
        default = null;
        description = "Workspace number or name to activate";
      };
      moveToWorkspace = mkOption {
        type = types.nullOr (
          types.oneOf [
            types.int
            types.str
          ]
        );
        default = null;
        description = "Workspace number or name to move window to";
      };
      moveFocus = mkOption {
        type = types.nullOr (
          types.enum [
            "left"
            "right"
            "up"
            "down"
          ]
        );
        default = null;
        description = "Direction to move focus";
      };
      layoutMsg = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Layout message to send";
      };
      toggleFloating = mkOption {
        type = types.nullOr types.anything;
        default = null;
        description = "Layout message to send";
      };
      exec = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Command to execute";
      };
      text = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Raw string";
      };
    };
  };

  binding = {
    options = {
      key = mkOption {
        type = types.str;
        description = "Key combination (e.g., '$mainMod SHIFT, W')";
      };
      action = mkOption {
        type = actionType;
        description = "Action to perform";
      };
      bindType = mkOption {
        type = types.enum [
          "bind"
          "bindel"
          "bindl"
          "bindm"
        ];
        default = "bind";
        description = "Type of binding";
      };
    };
  };
in
{
  options = {
    wayland.windowManager.hyprland = {
      bindings = mkOption {
        type = with types; listOf (submodule binding);
        default = [ ];
        description = "Structured keybindings with type checking";
      };
      header = mkOption {
        type = types.lines;
        default = "";
      };
    };
  };
  config =
    let
      inherit (config.wayland.windowManager) hyprland;

      actionToCommand =
        action:
        let
          actionToCommandMap = {
            text = a: a.text;
            activateWorkspace = a: "workspace, ${toString a.activateWorkspace}";
            moveToWorkspace = a: "movetoworkspace, ${toString a.moveToWorkspace}";
            moveFocus = a: "movefocus, ${a.moveFocus}";
            layoutMsg = a: "layoutmsg, ${a.layoutMsg}";
            exec = a: "exec, ${a.exec}";
            toggleFloating = a: "togglefloating";
          };

          propName =
            action
            |> lib.attrsToList
            |> lib.filter ({ value, ... }: value != null)
            |> lib.map ({ name, value }: name)
            |> (l: throwIf ((l |> lib.length) == 0) "Action missing ${l |> builtins.toJSON}" l)
            |> (l: throwIf ((l |> lib.length) > 1) "Action has multiple actions defined" l)
            |> (l: lib.elemAt l 0);
        in
        actionToCommandMap.${propName} action;

      bindings =
        hyprland.bindings
        |> map (binding: "${binding.bindType} = ${binding.key}, ${actionToCommand binding.action}")
        |> lib.concatLines;
    in

    {
      wayland.windowManager.hyprland = {
        extraConfig = ''
          ${hyprland.header}
          ${bindings}
          ${lib.readFile ../configs/hyprland.conf}
        '';
      };
    };
}
