{ pkgs, system, ... }@args:
{
  nix.extraOptions = ''
    !include nix.conf.d/shopify.conf
  '';
}
