{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.window-managers.hyprland.addons.notifications;
in
with lib;
{
  options.adace.desktop.window-managers.hyprland.addons.notifications.enable = mkEnableOption "notifications";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.libnotify ];
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
      anchor = "bottom-right";
      font = "JetBrainsMono Nerd Font 18";
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
