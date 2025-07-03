{
  config,
  lib,
  ...
}:
with lib;
{
  options = {
    defaultConfigs.syncthing.enable = mkEnableOption "";
  };
  config = mkIf (config.defaultConfigs.syncthing.enable) {
    services.syncthing = {
      settings = {
        devices = {
          surmcluster = {
            id = "CJT6SJ3-YD5KOXR-WRLN3GM-D5ALFHQ-7M6ZWSG-4MNKWG3-T525QU4-M77GYA3";
            addresses = [
              "tcp://10.0.0.2:22000"
              "tcp://sync.surmcluster.surmnet.surma.link:22000"
            ];
          };
        };
        folders = {
          "${config.home.homeDirectory}/sync/scratch" = {
            id = "hbza9-iimbx";
            devices = [ "surmcluster" ];
          };
        };
      };
      tray.enable = true;
    };
  };
}
