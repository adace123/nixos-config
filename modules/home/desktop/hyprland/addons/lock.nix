{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.desktop.hyprland.addons;
in
  with lib; {
    imports = [
      inputs.hyprlock.homeManagerModules.default
    ];
    config = mkIf cfg.enable {
      programs.hyprlock = {
        enable = true;
        general = {
          hide_cursor = false;
          grace = 300;
        };
        input-fields = [
          {
            outer_color = "rgb(24, 25, 38)";
            inner_color = "rgb(91, 96, 120)";
            font_color = "rgb(202, 211, 245)";
            halign = "center";
            valign = "bottom";
          }
        ];
        backgrounds = [
          {
            path = "${config.home.homeDirectory}/Pictures/wallpapers/telescope.jpg";
            blur_passes = 4;
          }
        ];
        labels = [
          {
            text = "<b>$TIME</b>";
            color = "rgb(255, 255, 255)";
            font_size = 96;
            position = {
              x = 0;
              y = 0;
            };
            halign = "center";
            valign = "top";
          }
          {
            text = ''cmd[update:1000] echo "$(date "+%a %d %b")"'';
            color = "rgb(255, 255, 255)";
            font_size = 24;
            position = {
              x = 0;
              y = -150;
            };
            halign = "center";
            valign = "top";
          }
          {
            text = "Hi there, <i>$USER</i>!";
            color = "rgb(255, 255, 255)";
            font_size = 32;
            position = {
              x = 0;
              y = 0;
            };
            halign = "center";
            valign = "center";
          }
          {
            text = "";
            color = "rgb(255, 255, 255)";
            font_family = "monospace";
            font_size = 32;
            position = {
              x = 0;
              y = 0;
            };
            halign = "center";
            valign = "bottom";
          }
        ];
      };
    };
  }
