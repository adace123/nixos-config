{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.desktop.hyprland;
in
  with lib; {
    options.desktop.hyprland.enable = mkEnableOption "Enable Hyprland";
    imports = [
      inputs.hyprland.homeManagerModules.default
      ./config.nix
      ./addons
    ];

    config = mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        nvidiaPatches = true;
      };

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
