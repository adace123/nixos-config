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
        default = 600;
      };
    };

    config = mkIf cfg.enable {
      home.packages = [pkgs.swayidle];

      services.swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.gtklock}/bin/gtklock";
          }
          {
            event = "lock";
            command = "${pkgs.gtklock}/bin/gtklock";
          }
        ];
        timeouts = [
          {
            inherit (cfg) timeout;
            command = "${pkgs.gtklock}/bin/gtklock";
          }
          {
            timeout = cfg.timeout + 5;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        systemdTarget = "hyprland-session.target";
      };
    };
  }
