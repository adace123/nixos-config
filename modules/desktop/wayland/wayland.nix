{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.desktop;
in
  with lib; {
    options.desktop.enable = mkEnableOption "Enable desktop environment (defaults to Wayland/hyprland)";

    config = mkIf cfg.enable {
      programs = {
        dconf.enable = true;
        light.enable = true;
      };

      xdg.portal = {
        enable = true;
        wlr.enable = true;
      };

      security.polkit.enable = true;

      # programs.hyprland = {
      #   enable = true;
      #   nvidiaPatches = config.sys.graphics.nvidia.enable;
      #   xwayland.hidpi = true;
      # };
      # programs.xwayland.enable = true;
      #
      # services.logind = {
      #   lidSwitch = "suspend";
      #   lidSwitchExternalPower = "lock";
      # };
      #
      # environment = {
      #   variables = {
      #     NIXOS_OZONE_WL = "1";
      #     __GL_GSYNC_ALLOWED = "0";
      #     __GL_VRR_ALLOWED = "0";
      #     _JAVA_AWT_WM_NONEREPARENTING = "1";
      #     SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      #     DISABLE_QT5_COMPAT = "0";
      #     GDK_BACKEND = "wayland";
      #     ANKI_WAYLAND = "1";
      #     DIRENV_LOG_FORMAT = "";
      #     WLR_DRM_NO_ATOMIC = "1";
      #     QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      #     QT_QPA_PLATFORM = "wayland";
      #     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      #     QT_QPA_PLATFORMTHEME = "qt5ct";
      #     QT_STYLE_OVERRIDE = "kvantum";
      #     MOZ_ENABLE_WAYLAND = "1";
      #     WLR_BACKEND = "vulkan";
      #     WLR_RENDERER = "vulkan";
      #     WLR_NO_HARDWARE_CURSORS = "1";
      #     XDG_SESSION_TYPE = "wayland";
      #     SDL_VIDEODRIVER = "wayland";
      #     CLUTTER_BACKEND = "wayland";
      #     WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      #   };
      # };
      #
      # systemd.services = {
      #   seatd = {
      #     enable = true;
      #     description = "Seat management daemon";
      #     script = "${pkgs.seatd}/bin/seatd -g wheel";
      #     serviceConfig = {
      #       Type = "simple";
      #       Restart = "always";
      #       RestartSec = "1";
      #     };
      #     wantedBy = ["multi-user.target"];
      #   };
      # };
      #
      # services.dbus.enable = true;
      #
      # xdg.portal = {
      #   enable = true;
      #   wlr.enable = false;
      #   extraPortals = with pkgs; [
      #     xdg-desktop-portal-gtk
      #     # xdg-desktop-portal-hyprland
      #   ];
      # };
      #
      # environment.etc."greetd/environments".text = ''
      #   Hyprland
      # '';
    };
  }
