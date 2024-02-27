{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
in
  with lib; {
    options.modules.desktop.hyprland.enable = mkEnableOption "Enable Hyprland";
    options.modules.desktop.hyprland.addons.enable = mkEnableOption "Enable Hyprland addons";

    imports = [
      ./config
      ./addons
    ];

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
        ];
      };
    };
  }
