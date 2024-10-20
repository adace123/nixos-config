{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.suites.system.peripherals;
in
with lib;
{
  options.adace.suites.system.peripherals.enable = mkEnableOption "Enable peripheral hardware";
  config = mkIf cfg.enable {
    adace.system = {
      bluetooth.enable = true;
      pipewire.enable = true;
    };
  };
}
