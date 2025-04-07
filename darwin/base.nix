{ pkgs, system, ... }@args:
{
  system.stateVersion = 5;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = "nix-command flakes";

  services.nix-daemon.enable = true;

  fonts.packages = with pkgs; [ fira-code ];

  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    casks = [
      "arc"
      "superwhisper"
      "barrier"
      "nvidia-geforce-now"
      "spotify"
      "discord"
      "signal"
      "slack"
      "zulip"
      "android-file-transfer"
    ];
  };

  # networking.computerName = "";
  # networking.hostName = "";
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
    };
    WindowManager = {
      StandardHideDesktopIcons = true;
    };
    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      autohide-time-modifier = 0.1;
      persistent-apps = [ ];
      persistent-others = [ "~/" ];
      show-recents = false;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };
    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 1;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = false;
    };
    screencapture = {
      disable-shadow = true;
      type = "png";
    };
  };
}
