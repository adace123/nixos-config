{
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.terminal.alacritty;
in
  with lib; {
    options.modules.desktop.terminal.alacritty.enable = mkEnableOption "alacritty";

    config = mkIf cfg.enable {
      programs.alacritty = {
        enable = true;

        settings = {
          env = {
            TERM = "xterm-256color";
          };

          window = {
            padding = {
              x = 20;
              y = 20;
            };

            dynamic_padding = true;
            dynamic_title = false;
            decorations_theme_variant = "Dark";
            opacity = 1.0;
          };

          font = {
            normal.family = "JetBrainsMono Nerd Font";
            size = 14;
            builtin_box_drawing = true;
          };

          cursor.style = {
            shape = "Beam";
            blinking = "On";
          };
        };
      };
    };
  }
