rec {
  baseConfig = import ./base-config.nix;
  default =
    args@{ pkgs, lib, ... }:
    let
      config = baseConfig args;
    in
    lib.recursiveUpdate config {
      home.packages = config.home.packages ++ [
        pkgs.arc-browser
        pkgs.telegram-desktop
        # pkgs.davinci-resolve
      ];
    };

  shopify =
    args@{ pkgs, lib, ... }:
    let
      config = baseConfig args;
    in
    config;

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
