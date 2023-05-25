{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
in
  with lib; {
    options.modules.desktop.hyprland.enable = mkEnableOption "Enable Hyprland";
    imports = [
      ./config.nix
      ./addons
    ];

    config = mkIf cfg.enable {
      home = {
        sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";
          XWAYLAND_NO_GLAMOR = "1";
          _JAVA_AWT_WM_NONREPARENTING = "1";
          MOZ_ENABLE_WAYLAND = "1";
          QT_QPA_PLATFORM = "wayland:xcb";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          SDL_VIDEODRIVER = "wayland";
          XDG_SESSION_TYPE = "wayland";
          NIXOS_OZONE_WL = "1";
        };

        packages = with pkgs; [
          # screenshot
          grim
          slurp

          # idle/lock
          swww
          swayidle
        ];
      };
    };
  }
