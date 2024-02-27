{config, ...}: let
  inherit (config.modules.desktop) monitor;
  inherit (config.home.sessionVariables) TERMINAL BROWSER;
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      sensitivity = 1.0;
      gaps_in = 8;
      gaps_out = 10;
      border_size = 3;
      "col.active_border" = "0xff9b5de5";
      "col.inactive_border" = "0xff${config.colorScheme.palette.base02}";
    };
    decoration = {
      active_opacity = 0.90;
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
      bezier = ["overshot, 0.13, 0.99, 0.29, 1.1"];
      animation = [
        "windows, 1, 4, overshot, slide"
        "border, 1, 10, default"
        "fade, 1, 10, default"
        "workspaces, 1, 6, overshot, slidevert"
      ];
    };

    dwindle = {
      pseudotile = 1;
      force_split = 0;
    };

    monitor = ["${monitor.output}, ${monitor.resolution}, 0x0, 1"];

    exec-once = [
      "${TERMINAL}"
      "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
      "${TERMINAL} --class scratchpad"
      "${BROWSER}"
      "pypr"
    ];

    windowrulev2 = [
      "opacity 1.0 override 1.0 override,class:^(firefox)$"
      "opacity 1.0 override 1.0 override,class:^(qutebrowser)$"
      "workspace special silent, class:^(scratchpad)$"
      "float, class:^(scratchpad)$"
      "center, class:^(scratchpad)$"
      "size 80% 85%, class:^(scratchpad)$"
    ];
  };
}
