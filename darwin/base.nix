{ pkgs, system, ... }@args:
let
  x = 1;
in
# pkgs = nixpkgs.legacyPackages.${system};

{
  system.stateVersion = 5;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = "nix-command flakes";

  services.nix-daemon.enable = true;

  fonts.packages = with pkgs; [ fira-code ];

  homebrew = {
    enable = true;
  };

  # networking.computerName = "";
  # networking.hostName = "";
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  system.defaults.NSGlobalDomain = {
    InitialKeyRepeat = 2;
    KeyRepeat = 15;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
  };
}
