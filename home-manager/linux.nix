{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = lib.mkDefault "surma";
  home.homeDirectory = lib.mkDefault "/home/surma";

}
