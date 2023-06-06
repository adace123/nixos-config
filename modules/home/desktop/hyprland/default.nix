{
  inputs,
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
  inherit (osConfig.modules.sys.graphics) nvidia;
in
  with lib; {
    options.modules.desktop.hyprland.enable = mkEnableOption "Enable Hyprland";
    imports = [
      ./config.nix
      ./addons
    ];

    config = mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        nvidiaPatches = nvidia.enable;
      };

      home = {
        packages = with pkgs; [
          # screenshot
          grim
          slurp
        ];
      };
    };
  }
