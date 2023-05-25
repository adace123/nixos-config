{
  config,
  lib,
  ...
}: let
  cfg = config.modules.window-manager.hyprland;
  inherit (config.sys.graphics) nvidia;
in
  with lib; {
    imports = [./greetd.nix];
    options.modules.window-manager = {
      hyprland.enable = mkEnableOption "Enable Hyprland";
    };

    config = mkIf cfg.enable {
      security = {
        pam.services.swaylock.text = "auth include login";
      };

      programs.hyprland = {
        enable = true;
        nvidiaPatches = nvidia.enable;
      };

      services.dbus.enable = true;

      programs = {
        light.enable = true;
      };
    };
  }
