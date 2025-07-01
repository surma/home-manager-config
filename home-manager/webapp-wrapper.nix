{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  inherit (pkgs) writeShellScriptBin writeTextFile symlinkJoin;

  webapp = (
    { config, ... }:
    {
      options = {
        url = mkOption {
          type = types.str;
        };
        title = mkOption {
          type = types.nullOr types.str;
          default = config.url;
        };
      };
    }
  );

  buildWebApp =
    {
      runner,
      name,
      webapp,
    }@args:
    let
      bin = writeShellScriptBin name (runner.invocation args);
      desktopItem = writeTextFile {
        name = "${name}.desktop";
        destination = "/share/applications/${name}.desktop";
        text = ''
          [Desktop Entry]
          Name=${webapp.title}
          Exec=${bin}/bin/${name}
          Terminal=false
          Type=Application
          StartupNotify=true
        '';
      };
    in
    symlinkJoin {
      inherit name;
      paths = [
        bin
        desktopItem
      ];
    };

in
{
  options = {
    programs.webapps = {
      runner = {
        package = mkOption {
          type = types.package;
          default = pkgs.chromium;
        };
        invocation = mkOption {
          type = with types; functionTo str;
          default = (
            { runner, webapp, ... }:
            "${runner.package}/bin/chromium --ozone-platform=wayland --new-window --app=${webapp.url} --name=${webapp.title}"
          );
        };
      };
      apps = mkOption {
        type = with types; attrsOf (submodule webapp);
        default = { };
      };
    };
  };
  config =
    let
      inherit (config.programs.webapps) apps runner;

      appPackages =
        apps
        |> lib.attrsToList
        |> lib.map (
          { name, value }:
          buildWebApp {
            inherit name runner;
            webapp = value;
          }
        );
    in
    {
      home.packages = appPackages;
    };
}
