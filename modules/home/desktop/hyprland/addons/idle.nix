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

      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = {
          daemonize = true;
          clock = true;
          screenshots = true;
          indicator = true;
          indicator-radius = 100;
          indicator-thickness = 7;
          effect-blur = "7x5";
          effect-vignette = "0.5:0.5";
          ring-color = "3b4252";
          key-hl-color = "880033";
          line-color = "00000000";
          inside-color = "00000088";
          separator-color = "00000000";
        };
      };

      services.swayidle = {
        enable = true;
        events = [
          {
            event = "lock";
            command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
          }
          {
            event = "before-sleep";
            command = "${pkgs.systemd}/bin/loginctl lock-session";
          }
        ];
        timeouts = [
          {
            inherit (cfg) timeout;
            command = "swaylock";
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
