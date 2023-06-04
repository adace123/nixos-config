{
  inputs,
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
  inherit (osConfig.modules.sys.graphics) nvidia;
in
  with lib; {
    options.modules.desktop.hyprland.enable = mkEnableOption "Enable Hyprland";
    imports = [
      ./config.nix
      ./addons
    ];

    config = mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        nvidiaPatches = nvidia.enable;
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
          swayidle
        ];
      };
    };
  }
