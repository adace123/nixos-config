{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.bluetooth;
in {
  options.modules.bluetooth.enable = mkEnableOption "bluetooth";
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          FastConnectable = true;
          JustWorksRepairing = "always";
          Privacy = "device";
        };
        Policy = {
          AutoEnable = true;
        };
        inputs = {
          UserSpaceHID = true;
        };
      };
      powerOnBoot = true;
    };
    environment.systemPackages = with pkgs; [bluez bluetuith];
  };
}
