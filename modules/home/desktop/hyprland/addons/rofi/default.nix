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
      home.packages = with pkgs; [
        rofi-systemd
        rofi-rbw
      ];

      xdg.configFile."rofi/theme.rasi".text = ''
                /*
         * ROFI color theme
         *
         * Based on Something Found in the Internet
         *
         * User: Contributors
         * Copyright: *!
         */

        configuration {
          font: "JetBrainsMono Nerd Font Medium 16";

          drun {
            display-name: "";
          }

          run {
            display-name: "";
          }

          window {
            display-name: "";
          }

          timeout {
            delay: 10;
            action: "kb-cancel";
          }
        }

        * {
          border: 0;
          margin: 0;
          padding: 0;
          spacing: 0;

          bg: #282a36;
          fg: #f8f8f2;
          blue: #6272a4;
          purple: #bd93f9;

          background-color: @bg;
          text-color: @fg;
        }

        window {
          transparency: "real";
          height: 45%;
          width: 35%;
        }

        mainbox {
          children: [inputbar, listview];
        }

        inputbar {
          background-color: @blue;
          children: [prompt, entry];
        }

        entry {
          background-color: inherit;
          padding: 12px 3px;
        }

        prompt {
          background-color: inherit;
          padding: 12px;
        }

        listview {
          lines: 8;
        }

        element {
          children: [element-icon, element-text];
          text-color: @blue;
        }

        element-icon {
          padding: 10px 10px;
        }

        element-text {
          padding: 10px 0;
          text-color: inherit;
        }

        element-text selected {
          text-color: @purple;
        }
      '';

      programs.rofi = {
        enable = true;
        terminal = "${pkgs.alacritty}/bin/alacritty";
        theme = "./theme.rasi";
        plugins = with pkgs; [
          rofi-calc
          rofi-emoji
          rofi-bluetooth
          rofi-systemd
          rofi-rbw
          rofi-power-menu
        ];
        location = "center";
        extraConfig = {
          show-icons = true;
        };
      };
    };
  }
