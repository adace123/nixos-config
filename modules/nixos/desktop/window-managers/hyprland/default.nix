{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.desktop.window-managers.hyprland;
in
with lib;
{
  options.adace.system.desktop.window-managers.hyprland.enable = mkEnableOption "Enable Hyprland";

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_SESSION_TYPE = "wayland";
      LIBSEAT_BACKEND = "logind";
    };

    programs.hyprland.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-hyprland
      ];
    };

    security.polkit.enable = true;

    services.dbus.enable = true;

    security.pam.services.hyprlock.text = "auth include login";
  };
}
