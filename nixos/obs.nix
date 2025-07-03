{
  config,
  pkgs,
  lib,
  ...
}:
let
  # As of now, need to downgrade v4l2loopback because v0.14 is incompatible with OBS' virtual cam.
  # OBS Version: 31.0.3, Latest attempt: 2025-07-03
  v4l2loopback-0132 = pkgs.callPackage ../extra-pkgs/v4l2loopback-0132 { inherit config; };
in
with lib;
{
  options = {
    programs.obs = {
      enable = mkEnableOption "";
    };
  };

  config = mkIf (config.programs.obs.enable) {

    boot.kernelModules = [
      "v4l2loopback"
    ];
    boot.extraModulePackages = [
      v4l2loopback-0132
    ];

    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    environment.systemPackages = [
      pkgs.obs-studio
    ];
  };
}
