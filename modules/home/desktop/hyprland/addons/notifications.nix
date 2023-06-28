{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.notifications;
  inherit (config.colorscheme) colors;
in
  with lib; {
    options.modules.desktop.notifications.enable = mkEnableOption "Desktop notifications";

    config = mkIf cfg.enable {
      home.packages = [pkgs.libnotify];

      services.mako = with colors; {
        enable = true;
        defaultTimeout = 5000;
        anchor = "bottom-right";
        font = "JetBrainsMono Nerd Font 18";
        backgroundColor = "#${base00}";
        textColor = "#${base05}";
        width = 350;
        borderSize = 2;
        borderRadius = 8;
        padding = "10";
        margin = "0,50,50";
        extraConfig = ''
          [urgency=low]
          border-color=#8be9fd

          [urgency=normal]
          border-color=#bd93f9

          [urgency=high]
          border-color=#ff5555
          default-timeout=0
        '';
      };
    };
  }
