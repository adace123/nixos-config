{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland.addons;
in
  with lib; {
    imports = [
      inputs.hyprlock.homeManagerModules.default
    ];
    config = mkIf cfg.enable {
      home.packages = [inputs.hyprlock.packages.${pkgs.system}.default];
      programs.hyprlock = {
        enable = true;

        general = {
          disable_loading_bar = false;
          hide_cursor = true;
          grace = 2;
          no_fade_in = false;
        };

        input-fields = [
          {
            size = {
              width = 300;
              height = 50;
            };
            outline_thickness = 3;
            dots_size = 0.33;
            dots_spacing = 0.15;
            dots_center = true;
            outer_color = "rgba(255, 255, 255, 0.1)";
            inner_color = "rgba(255, 255, 255, 0.1)";
            font_color = "rgb(255, 255, 255)";
            fade_on_empty = true;
            placeholder_text = "<i>Input Password...</i>";
            hide_input = false;
            position = {
              x = 0;
              y = -90;
            };
            halign = "center";
            valign = "center";
          }
        ];

        labels = [
          {
            text = "$TIME";
            color = "rgba(203, 195, 227, 1.0)";
            font_family = "JetBrainsMono Nerd Font";
            font_size = 72;
            halign = "center";
            valign = "center";
          }
          {
            text = "Welcome back, $USER!";
            color = "rgba(203, 195, 227, 1.0)";
            font_family = "JetBrainsMono Nerd Font";
            font_size = 72;
            halign = "center";
            valign = "top";
            position = {
              y = -20;
            };
          }
        ];

        backgrounds = [
          {
            path = "${config.home.homeDirectory}/Pictures/wallpapers/sci-fi-sunset.png";
          }
        ];
      };
    };
  }
