{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  config = {

    home.packages = (with pkgs; [ ffmpeg ]);
    programs.yt-dlp.enable = true;
  };
}
