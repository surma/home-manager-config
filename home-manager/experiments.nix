{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;

  # zig = callPackage (import ../extra-pkgs/zig) { };
in
{
  home.packages =
    (with pkgs; [
      (callPackage (import ../extra-pkgs/opencode) { })
    ])
    ++ [
    ];
}
