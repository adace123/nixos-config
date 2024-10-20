{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.graphical.window-managers.hyprland.addons.rofi;
in
with lib;
{
  options.adace.programs.graphical.window-managers.hyprland.addons.rofi.enable = mkEnableOption "rofi";
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "JetBrainsMono Nerd Font";
      catppuccin.enable = true;
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
