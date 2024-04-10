{
  config,
  lib,
  pkgs,
  std,
  ...
}: let
  cfg = config.modules.desktop.hyprland.addons;
in
  with lib; {
    config = mkIf cfg.enable {
      home.packages = [pkgs.pyprland];
      xdg.configFile.pypr = {
        target = "hypr/pyprland.toml";
        text = std.serde.toTOML {
          pyprland.plugins = ["scratchpads"];
          scratchpads = {
            terminal = {
              command = "alacritty --class=scratchpad";
              animation = "fromTop";
              unfocus = "hide";
            };
            btm = {
              command = "alacritty --class=scratchpad -e btm";
              animation = "fromTop";
              unfocus = "hide";
            };
            tgpt = {
              command = "alacritty --class=scratchpad -e tgpt -i";
              animation = "fromTop";
              unfocus = "hide";
            };
            yazi = {
              command = "alacritty --class=scratchpad -e yazi ~";
              animation = "fromTop";
              unfocus = "hide";
            };
          };
        };
      };
    };
  }
