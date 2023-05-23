{
  config,
  lib,
  ...
}: let
  cfg = config.window-manager;
in
  with lib; {
    imports = [./xdg.nix ./greetd.nix];
    options.window-manager = {
      enable = mkEnableOption "Enable window-manager (defaults to Wayland)";
      name = mkOption {
        type = lib.types.enum ["hyprland"];
        default = "hyprland";
      };
    };

    config = mkIf cfg.enable {
      security = {
        polkit.enable = true;
        pam.services.swaylock.text = "auth include login";
      };

      programs.${cfg.name}.enable = true;

      services.dbus.enable = true;

      programs = {
        dconf.enable = true;
        light.enable = true;
      };
    };
  }
