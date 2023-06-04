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
      lockTimeout = mkOption {type = types.int; default = 300;};
      screenTimeout = mkOption {type = types.int; default = 350;};
    };

    config = mkIf cfg.enable {
      services.swayidle = {
        enable = true;
        events = [
          {
            event = "lock";
            command = "${pkgs.gtklock}/bin/gtklock";
          }
        ];
        timeouts = [
          {
            timeout = cfg.lockTimeout;
            command = "${pkgs.gtklock}/bin/gtklock";
          }
          {
            timeout = cfg.screenTimeout;
            command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
            resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          }
        ];
        systemdTarget = "hyprland-session.target";
      };
    };
  }
