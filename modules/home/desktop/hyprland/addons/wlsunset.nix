{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.desktop.hyprland.addons;
in
with lib;
{
  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      latitude = "34.073620";
      longitude = "-118.400352";
      temperature = {
        day = 5300;
        night = 4500;
      };
    };
  };
}
