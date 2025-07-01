{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let

  orDefault = def: val: if val == null then def else val;

  command = {
    options = {
      variable = mkOption {
        type = types.str;
      };
      package = mkOption {
        type = types.package;
        default = pkgs.wofi;
      };
      bin = mkOption {
        type = types.nullOr types.path;
        default = null;
      };
      args = mkOption {
        type = with types; listOf str;
        default = [ ];
      };
    };
  };
  execShortcut = {
    options = {
      extraMods = mkOption {
        type = types.str;
        default = "";
      };
      key = mkOption {
        type = types.str;
      };
      command = mkOption {
        type = types.str;
      };
    };
  };
in
{
  options = {
    wayland.windowManager.hyprland = {
      mainMod = mkOption {
        type = types.str;
        default = "SUPER";
      };
      commands = mkOption {
        type = with types; listOf (submodule command);
        default = [ ];
      };
      execShortcuts = mkOption {
        type = with types; listOf (submodule execShortcut);
        default = [ ];
      };
    };
  };
  config =
    let
      inherit (config.wayland.windowManager) hyprland;

      commandVariables =
        hyprland.commands
        |> map (
          cmd:
          let
            mainProgram =
              lib.throwIf (!(cmd.package.meta ? mainProgram))
                "Package ${cmd.package.name} does not have a main program defined. Please specify `bin` for variable \$${cmd.variable}."
                cmd.package.meta.mainProgram;
            invocation = cmd.bin |> orDefault "${cmd.package}/bin/${mainProgram}";
            args = cmd.args |> lib.concatStringsSep " ";
          in
          "\$${cmd.variable} = ${invocation} ${args}"
        )
        |> lib.concatLines;

      execBinds =
        hyprland.execShortcuts
        |> map (
          shortcut: "bind = $mainMod ${shortcut.extraMods}, ${shortcut.key}, exec, ${shortcut.command}"
        )
        |> lib.concatLines;
    in

    {
      home.packages = hyprland.commands |> lib.map (v: v.package);
      wayland.windowManager.hyprland = {
        extraConfig = ''
          $mainMod = ${hyprland.mainMod}
          ${commandVariables}
          ${execBinds}
          ${lib.readFile ../configs/hyprland.conf}
        '';
      };
    };
}
