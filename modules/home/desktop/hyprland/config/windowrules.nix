{...}: {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "opacity 1.0 override 1.0 override,class:^(firefox)$"
    "opacity 1.0 override 1.0 override,class:^(qutebrowser)$"
    "workspace special silent, class:^(scratchpad)$"
    "float, class:^(scratchpad)$"
    "center, class:^(scratchpad)$"
    "size 80% 85%, class:^(scratchpad)$"
  ];
}
