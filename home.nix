let
  pkgs = import <nixpkgs> { };
  lib = pkgs.lib;
  machinesDir = "${./.}/machines";
  machinesDirContent = builtins.readDir machinesDir;
  machineFiles = lib.filter (file: lib.strings.hasSuffix ".nix" file) (
    lib.attrNames machinesDirContent
  );
  machines = lib.listToAttrs (
    lib.map (file: {
      name = lib.strings.removeSuffix ".nix" file;
      value = "${machinesDir}/${file}";
    }) machineFiles
  );
in
machines
// rec {
  default = machines.surmbook;

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
