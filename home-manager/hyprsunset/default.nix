{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.programs) hyprsunset;
in
with lib;
{
  options = {
    programs.hyprsunset = {
      enable = mkEnableOption "";
      package = mkPackageOption pkgs "hyprsunset" { };
    };
  };
  config = mkIf hyprsunset.enable {
    home.packages = [ hyprsunset.package ];
    systemd.user.services.hyprsunset = {
      Unit = {
        Description = "Starts hyprsunset to control tint and gamma";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${hyprsunset.package}/bin/hyprsunset";
      };
    };
  };
}
