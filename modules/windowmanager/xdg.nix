{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.window-manager;
in
  with lib; {
    config = mkIf cfg.enable {
      xdg = {
        portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-hyprland
            xdg-desktop-portal-gtk
          ];
        };
      };
    };
  }
