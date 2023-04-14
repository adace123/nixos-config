{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.hardware.networking.wifi;
in {
  options.modules.hardware.networking.wifi.enable = mkEnableOption "wifi";

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;
  };
}
