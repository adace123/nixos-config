{
  pkgs,
  nixos-hardware,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.sys.bluetooth;
in {
  options.sys.bluetooth.enable = mkEnableOption "bluetooth";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      powerOnBoot = true;
      enable = mkEnableOption "bluetooth";
      # battery info support
      package = pkgs.bluez5-experimental;
      # HSP/HFP support
      hsphfpd.enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
