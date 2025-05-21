{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;

  zig = callPackage (import ../extra-pkgs/zig) { };
in
{
  home.packages =
    (with pkgs; [
      rusty-man
      mprocs
      wiki-tui
      dua
      fish
    ])
    ++ [
      (callPackage (import ../extra-pkgs/aider) { })
      zig.zig
      zig.zls
    ];
}
