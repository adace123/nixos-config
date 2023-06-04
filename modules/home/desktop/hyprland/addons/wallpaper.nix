{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.desktop) wallpaper hyprland;
in
  with lib; {
    config = mkIf (wallpaper
      != null
      && hyprland.enable) {
      home.packages = [pkgs.hyprpaper];

      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${wallpaper}
        wallpaper = ,${wallpaper}
      '';

      systemd.user.services = {
        hyprpaper = {
          Unit = {
            Description = "Hyprpaper wallpaper";
            After = ["hyprland-session.target"];
          };
          Service = {
            ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
            Restart = "always";
            Type = "simple";
          };
          Install.WantedBy = ["hyprland-session.target"];
        };
      };
    };
  }
