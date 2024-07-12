{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.surmtest;
in
{
  options = {
    programs.surmtest = {
      enable = mkEnableOption "Surmtest";
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."surmtest/surmtest.txt" = {
      source = derivation {
        system = builtins.currentSystem;
        name = "lol";
        builder = "${pkgs.bash}/bin/bash";
        args = [
          "-c"
          "echo LOL > $out"
        ];
      };
    };
  };
}
