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
      services.greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "Hyprland";
            user = config.user.name;
          };
          default_session = initial_session;
        };
      };

      fonts.fonts = with pkgs; [
        material-symbols
        roboto
        (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
      ];

      programs = {
        dconf.enable = true;
        light.enable = true;
      };

      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
        ];
      };

      security = {
        polkit.enable = true;
        pam.services.swaylock.text = "auth include login";
      };

      services.dbus.enable = true;
    };
  }
