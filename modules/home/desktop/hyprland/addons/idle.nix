{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.idle;
in
  with lib; {
    options.modules.desktop.idle = {
      enable = mkEnableOption "enable swayidle";
      timeout = mkOption {
        type = types.int;
        default = 500;
      };
    };

    config = mkIf cfg.enable {
      home.packages = [pkgs.swayidle];

      services.swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.gtklock}/bin/gtklock -d";
          }
          {
            event = "lock";
            command = "${pkgs.gtklock}/bin/gtklock -d";
          }
        ];
        timeouts = [
          {
            inherit (cfg) timeout;
            command = "${pkgs.gtklock}/bin/gtklock -d";
          }
          {
            timeout = cfg.timeout + 320;
            command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
            resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          }
          {
            timeout = cfg.timeout + 500;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        systemdTarget = "hyprland-session.target";
      };
    };
  }
