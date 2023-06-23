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
    };
    environment.systemPackages = with pkgs; [bluez bluetuith];
  };
}
