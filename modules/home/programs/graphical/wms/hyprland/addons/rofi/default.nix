{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.window-managers.hyprland.addons.rofi;
in
with lib;
{
  options.adace.desktop.window-managers.hyprland.addons.rofi.enable = mkEnableOption "rofi";
  config = mkIf cfg.enable {
    catppuccin.rofi.enable = true;
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "JetBrainsMono Nerd Font";
      plugins = [ ];
      extraConfig = {
        modi = "run,drun,window";
        icon-theme = "Fluent-dark";
        show-icons = true;
        disable-history = true;
      };
    };
  };
}
