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
            size = 16;
            builtin_box_drawing = true;
          };

          cursor.style = {
            shape = "Beam";
            blinking = "On";
          };

          colors = with config.colorScheme.palette; {
            cursor = {
              text = "0x${base00}";
              cursor = "0x${base05}";
            };

            selection = {
              text = "0x${base00}";
              background = "0x${base05}";
            };

            primary = {
              background = "0x${base00}";
              foreground = "0x${base05}";
            };

            normal = {
              black = "0x${base00}";
              red = "0x${base08}";
              green = "0x${base0B}";
              yellow = "0x${base0A}";
              blue = "0x${base0D}";
              magenta = "0x${base0E}";
              cyan = "0x${base0C}";
              white = "0x${base05}";
            };

            bright = {
              black = "0x${base03}";
              red = "0x${base09}";
              green = "0x${base01}";
              yellow = "0x${base02}";
              blue = "0x${base04}";
              magenta = "0x${base06}";
              cyan = "0x${base0F}";
              white = "0x${base07}";
            };
          };
        };
      };
    };
  }
