{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../machines/surmframework-hardware.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
    ./base.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "surmframework"; # Define your hostname.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];

  programs._1password-gui.enable = true;

  users.users.surma = {
    isNormalUser = true;
    description = "Surma";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    wireplumber
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
