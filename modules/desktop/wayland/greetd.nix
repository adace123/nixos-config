{
  config,
  lib,
  ...
}: let
  cfg = config.desktop;
in
  with lib; {
    config = mkIf cfg.enable {
      services.greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "Hyprland";
            user = config.user.name;
          };
          default_session = initial_session;
        };
      };
    };
  }
