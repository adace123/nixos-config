{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.window-manager.hyprland;
in
  with lib; {
    imports = [./greetd.nix];
    options.modules.window-manager.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
        XDG_SESSION_TYPE = "wayland";
        QT_QPA_PLATFORM = "xcb";
        LIBSEAT_BACKEND = "logind";
      };

      programs.hyprland.enable = true;

      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-hyprland];
      };

      security.polkit.enable = true;

      services.dbus.enable = true;

      security.pam.services.gtklock.text = ''
        auth include login
      '';
    };
  }
