{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.window-manager.hyprland;
  inherit (config.modules.sys.graphics) nvidia;
in
  with lib; {
    imports = [./greetd.nix];
    options.modules.window-manager.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      security = {
        pam.services.gtklock.text = ''
          auth include login
          auth sufficient pam_unix.so try_first_pass likeauth nullok
        '';
      };

      environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
        XDG_SESSION_TYPE = "wayland";
        QT_QPA_PLATFORM = "wayland";
      };

      programs.hyprland.enable = true;

      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-hyprland];
      };

      security.polkit.enable = true;
    };
  }
