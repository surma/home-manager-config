{ nix-system-graphics, system-manager, config, pkgs, lib, ... }:

let
  inherit (pkgs) callPackage;
  systemManagerModule = callPackage (import "${system-manager}/nix/modules") {inherit system-manager;};
in
{
  imports = [
    ../home-manager/base.nix
    ../home-manager/dev.nix
    ../home-manager/nixdev.nix
    ../home-manager/linux.nix
    ../home-manager/graphical.nix
    ../home-manager/workstation.nix
    ../home-manager/wezterm.nix
  ];

  options = with lib; {
    system-manager = with types; mkOption {
      type = nullOr (submodule {inherit (systemManagerModule) options config imports;});
      default = null;
    };
  };

  config = {
    system-manager =  {
      imports = [
        # nix-system-graphics.systemModules.default
        # ../system-manager/base.nix
      ];
    };

    home.activation.myScript = (lib.hm.dag.entryAfter ["writeBoundary"] ''
      # nix run 'github:numtide/system-manager -- --flake'
    '');

    home.packages = (
      with pkgs;
      [
        # hyprland
      ]
    );

    home.stateVersion = "24.05";

    home.sessionVariables.FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/.config/home-manager#surmframework";

    programs.wezterm.frontend = "OpenGL";
    wayland.windowManager.hyprland = {
      enable = false;
      extraConfig = ''
        # lol
      '';
      # set the flake package
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}
