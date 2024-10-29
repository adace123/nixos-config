{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.suites.desktop;
in
with lib;
{
  options.adace.suites.desktop.enable = mkEnableOption "Desktop";
  config = mkIf cfg.enable {
    adace.system.desktop = {
      display-managers.tuigreet.enable = true;
      window-managers.hyprland.enable = true;
    };
  };
}
