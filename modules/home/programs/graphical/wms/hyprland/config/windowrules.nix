{ config, lib, ... }:
let
  cfg = config.adace.programs.graphical.window-managers.hyprland;
in
with lib;
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "opacity 1.0 override 1.0 override,class:^(qutebrowser)$"
      "workspace special silent, class:^(scratchpad)$"
      "float, class:^(scratchpad)$"
      "center, class:^(scratchpad)$"
      "size 80% 85%, class:^(scratchpad)$"
    ];
  };
}
