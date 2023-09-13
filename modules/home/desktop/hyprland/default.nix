{
  inputs,
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
  inherit (osConfig.modules.graphics) nvidia;
in
  with lib; {
    options.modules.desktop.hyprland.enable = mkEnableOption "Enable Hyprland";
    imports = [
      ./settings.nix
      ./addons
    ];

    config = mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        enableNvidiaPatches = nvidia.enable;
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
