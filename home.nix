let
  baseConfigFactory = import ./base.nix;
  createOverlay =
    path:
    args@{ pkgs, lib, ... }:
    let
      baseConfig = baseConfigFactory args;
      overlay = import path { inherit pkgs baseConfig; };
    in
    lib.recursiveUpdate baseConfig overlay;
in
rec {
  default = surmbook;
  surmbook = createOverlay ./machines/surmbook.nix;
  shopify = createOverlay ./machines/shopify.nix;

  # This is what makes `home-manager switch` enable the `default` config
  # when no explicit `-A <profile name>` is present.
  __functor =
    self:
    args@{
      config,
      pkgs,
      lib,
      ...
    }:
    default args;
}
