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
    ])
    ++ [
      (callPackage (import ../extra-pkgs/aider) { })
      zig.zig
      zig.zls
    ];
}
