{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.window-manager.hyprland;
in
with lib;
{
  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember-user-session --remember --asterisks --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    environment.etc."greetd/environments".text = ''
      Hyprland
    '';
  };
}
