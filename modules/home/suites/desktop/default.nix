{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.suites.desktop;
in
with lib;
{
  options.adace.suites.desktop.enable = mkEnableOption "NixOS desktop suite";
  config = mkIf cfg.enable {
    adace.desktop = {
      window-managers.hyprland = {
        enable = true;
        addons = {
          hypridle.enable = true;
          hyprlock.enable = true;
          notifications.enable = true;
          pyprland.enable = true;
          rofi.enable = true;
          wallpaper.enable = true;
          waybar.enable = true;
          wlsunset.enable = true;
        };
      };
      browsers = {
        qutebrowser = {
          enable = true;
          isDefaultBrowser = true;
        };
        floorp.enable = true;
      };
      editors = {
        vscode.enable = true;
      };
      media.mpv.enable = true;
      social.discord.enable = true;
    };
  };
}
