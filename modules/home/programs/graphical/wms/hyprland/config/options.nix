{ config, lib, ... }:
let
  inherit (config.adace.home.desktop) monitor;
  inherit (config.home.sessionVariables) TERMINAL BROWSER;
  cfg = config.adace.desktop.window-managers.hyprland;
in
with lib;
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        env = [
          "DOTFILES_DIR,${config.home.homeDirectory}/nixos-config"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];
        general = {
          gaps_in = 6;
          gaps_out = 8;
          border_size = 3;
          "col.active_border" = "0xff9b5de5";
        };

        decoration = {
          active_opacity = 0.9;
          inactive_opacity = 0.84;
          fullscreen_opacity = 1.0;
          rounding = 5;
          drop_shadow = true;
          shadow_range = 12;
          shadow_offset = "3 3";
          "col.shadow" = "0x44000000";
          "col.shadow_inactive" = "0x66000000";
        };

        animations = {
          enabled = true;
          bezier = [ "overshot, 0.13, 0.99, 0.29, 1.1" ];
          animation = [
            "windows, 1, 4, overshot, slide"
            "border, 1, 10, default"
            "fade, 1, 10, default"
            "workspaces, 1, 6, overshot, slidevert"
          ];
        };

        cursor.no_hardware_cursors = true;

        dwindle = {
          pseudotile = 1;
          force_split = 0;
        };

        monitor = [ "${monitor.output}, ${monitor.resolution}, 0x0, 1" ];

        exec-once = [
          "${TERMINAL}"
          "${TERMINAL} --class scratchpad"
          "${BROWSER}"
          "pypr"
        ];
      };
    };
  };
}
