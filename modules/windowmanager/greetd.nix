{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.window-manager;
in
  with lib; {
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        (catppuccin-gtk.override {
          accents = ["mauve"];
          size = "compact";
          variant = "mocha";
        })
        bibata-cursors
        papirus-icon-theme
      ];

      programs.${cfg.name}.enable = true;

      programs.regreet = {
        enable = true;
        settings = {
          GTK = {
            cursor_theme_name = "Bibata-Modern-Classic";
            font_name = "Jost * 12";
            icon_theme_name = "Papirus-Dark";
            theme_name = "Catppuccin-Mocha-Compact-Mauve-Dark";
          };
        };
      };
    };
  }
