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
        general.grace = 300;
        input-fields = [
          {
            outer_color = "rgb(24, 25, 38)";
            inner_color = "rgb(91, 96, 120)";
            font_color = "rgb(202, 211, 245)";
            halign = "center";
            valign = "bottom";
            placeholder_text = "<i>Input Password...</i>";
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
