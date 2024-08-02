rec {
  default = surmbook;
  surmbook = ./machines/surmbook.nix;
  shopify = ./machines/shopify.nix;

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
