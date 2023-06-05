{
  config,
  lib,
  ...
}: let
  cfg = config.modules.window-manager.hyprland;
  inherit (config.modules.sys.graphics) nvidia;
in
  with lib; {
    imports = [./greetd.nix];
    options.modules.window-manager.hyprland.enable = mkEnableOption "Enable Hyprland";

    config = mkIf cfg.enable {
      security = {
        pam.services.gtklock.text = ''
          auth include login
          auth sufficient pam_unix.so try_first_pass likeauth nullok
        '';
      };

      programs.hyprland.enable = true;

      services.dbus.enable = true;

      programs.light.enable = true;
    };
  }
