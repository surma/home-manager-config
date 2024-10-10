{ ... }@args:

{
  system.stateVersion = 5;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = "nix-command flakes";

  services.nix-daemon.enable = true;

  # system.configurationRevision = self.rev or self.dirtyRev or null;
}
