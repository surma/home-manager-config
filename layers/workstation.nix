{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {
  nixpkgs.config.allowUnfreePredicate =
    pkg: (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ ];

  home.packages =
    prev.home.packages
    ++ (with pkgs; [
      podman
      podman-compose
      just
      ffmpeg
      wabt
      wasmtime
      nodejs.pkgs.typescript-language-server
    ]);
  programs.yt-dlp.enable = true;
}
