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
      home.packages = [pkgs.swww];

      systemd.user.services = {
        swww = {
          Unit = {
            Description = "Swww wallpaper";
            After = ["hyprland-session.target"];
          };
          Service = {
            ExecStart = "${pkgs.swww}/bin/swww-daemon";
            ExecStop = "${pkgs.swww}/bin/swww kill";
            Restart = "on-failure";
            Type = "simple";
          };
          Install.WantedBy = ["hyprland-session.target"];
        };

        set_wallpaper = {
          Unit = {
            Description = "Set default wallpaper";
            Requires = ["swww.service"];
            After = ["swww.service"];
            PartOf = ["swww.service"];
          };
          Install.WantedBy = ["swww.service"];
          Service = {
            ExecStart = "${pkgs.swww}/bin/swww img ${wallpaper}";
            Restart = "on-failure";
            Type = "oneshot";
          };
        };
      };
    };
  }
