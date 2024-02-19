{
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.yabai;
in
  with lib; {
    options.modules.desktop.yabai.enable = mkEnableOption "yabai";
    config = mkIf cfg.enable {
      services.yabai = {
        enable = true;
        enableScriptingAddition = true;
        config = {
          layout = "bsp";
          window_border = "on";
          window_border_width = "2";
          window_placement = "second_child";
          focus_follows_mouse = "autoraise";
          mouse_follows_focus = "off";
          top_padding = "10";
          bottom_padding = "10";
          left_padding = "10";
          right_padding = "10";
          window_gap = "5";
        };
        extraConfig = ''
          yabai -m rule --add app="System Preferences"  manage="off"
        '';
      };

      services.skhd = {
        enable = true;
        skhdConfig = ''
          # Open Terminal
          alt - return : /usr/local/bin/wezterm

          # Toggle Window
          lalt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
          lalt - f : yabai -m window --toggle zoom-fullscreen
          lalt - q : yabai -m window --close

          # Focus Window
          lalt - k : yabai -m window --focus north
          lalt - j : yabai -m window --focus south
          lalt - h : yabai -m window --focus west
          lalt - l : yabai -m window --focus east

          # Resize Window
          shift + alt - left : yabai -m window --resize left:-50:0 && yabai -m window --resize right:-50:0
          shift + alt - right : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0
          shift + alt - up : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
          shift + alt - down : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0

          # Focus Space
          ctrl - 1 : yabai -m space --focus 1
          ctrl - 2 : yabai -m space --focus 2
          ctrl - 3 : yabai -m space --focus 3
          ctrl - 4 : yabai -m space --focus 4
          ctrl - 5 : yabai -m space --focus 5
        '';
      };
    };
  }
