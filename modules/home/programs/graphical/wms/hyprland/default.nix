{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.adace.desktop.window-managers.hyprland;
in
with lib;
{
  options.adace.desktop.window-managers.hyprland = {
    enable = mkEnableOption "Enable Hyprland";
    addons.enable = mkEnableOption "Enable Hyprland addons";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
    };

    home = {
      packages = with pkgs; [
        grimblast
        wl-clipboard
        swayimg
        wtype
        inputs.hyprkeys.packages.${pkgs.system}.default
        xdg-utils
      ];
    };
  };
}
