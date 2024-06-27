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
        catppuccin.enable = true;
        plugins = [];
        extraConfig = {
          modi = "run,drun,window";
          icon-theme = "Fluent-dark";
          show-icons = true;
          disable-history = true;
        };
      };
    };
  }
