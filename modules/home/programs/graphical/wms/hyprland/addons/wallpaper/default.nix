{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.window-managers.hyprland.addons.wallpaper;
in
with lib;
{
  options.adace.desktop.window-managers.hyprland.addons.wallpaper.enable = mkEnableOption "wallpaper";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.swww ];

    home.file."Pictures/wallpapers".source = inputs.wallpapers;

    wayland.windowManager.hyprland.settings.exec-once = [
      # "${pkgs.swww}/bin/swww-daemon; sleep 1; ${pkgs.swww}/bin/swww img ${wallpaper}"
    ];
  };
}
