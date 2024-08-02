{ pkgs, lib, ... }:
final: prev:
lib.recursiveUpdate prev {

  nixpkgs.config.allowUnfreePredicate =
    pkg: (prev.nixpkgs.config.allowUnfreePredicate pkg) || builtins.elem (lib.getName pkg) [ ];

  home.packages =
    prev.home.packages
    ++ (with pkgs; [
      telegram-desktop
      audacity
      fira-code
      obsidian
      vscode
      vlc-bin
    ]);

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = wezterm.config_builder()
      config.send_composed_key_when_left_alt_is_pressed = true
      -- config.color_scheme = 'Everforest Dark (Gogh)'
      -- config.color_scheme = 'Everforest Light (Gogh)'
      config.color_scheme = 'Gruvbox Dark (Gogh)'
      -- config.color_scheme = 'Everforest Light (Gogh)'
      config.font = wezterm.font 'Fira Code'
      config.font_size = 16.0
      config.hide_tab_bar_if_only_one_tab = true
      return config
    '';
  };
}
