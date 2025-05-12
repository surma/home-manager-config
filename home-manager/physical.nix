{ config, pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  config = {

    home.packages = (with pkgs; [ ffmpeg ]) ++ [ (callPackage (import ../extra-pkgs/ollama) { }) ];
    programs.yt-dlp.enable = true;
  };
}
