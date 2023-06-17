{
  pkgs,
  nixos-hardware,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.sys.bluetooth;
 in {
  options.modules.sys.bluetooth.enable = mkEnableOption "bluetooth";
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          ControllerMode = "bredr";
          AutoEnable = "true";
          AutoConnect = "true";
          MultiProfile = "multiple";
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    environment.systemPackages = with pkgs; [bluez bluetuith];
  };
}
