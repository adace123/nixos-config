{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.suites.system.desktop;
in
with lib;
{
  options.adace.suites.system.desktop.enable = mkEnableOption "Desktop";
  config = mkIf cfg.enable {
    adace.system.desktop = {
      display-managers.tuigreet.enable = true;
      window-managers.hyprland.enable = true;
    };
  };
}
