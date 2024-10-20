{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.programs.graphical.window-managers.hyprland.addons.wlsunset;
in
with lib;
{
  options.adace.programs.graphical.window-managers.hyprland.addons.wlsunset.enable = mkEnableOption "wlsunset";
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
