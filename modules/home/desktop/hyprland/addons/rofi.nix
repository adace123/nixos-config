{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland.addons;
in
  with lib; {
    config = mkIf cfg.enable {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        font = "JetBrainsMono Nerd Font";
        terminal = "wezterm";
      };
    };
  }
