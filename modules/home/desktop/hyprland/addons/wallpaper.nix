{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (config.modules.desktop) wallpaper hyprland;
in
  with lib; {
    config = mkIf (wallpaper
      != null
      && hyprland.enable) {
      home.packages = [pkgs.swww];

      home.file."Pictures/wallpapers".source = inputs.wallpapers;

      wayland.windowManager.hyprland.settings.exec-once = [
        "${pkgs.swww}/bin/swww-daemon; sleep 1; ${pkgs.swww}/bin/swww img ${wallpaper}"
      ];
    };
  }
