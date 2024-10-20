{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.desktop.display-managers.tuigreet;
in
with lib;
{
  options.adace.system.desktop.display-managers.tuigreet.enable = mkEnableOption "tuigreet";
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
