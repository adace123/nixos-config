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
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    environment.systemPackages = [pkgs.bluez];
  };
}
