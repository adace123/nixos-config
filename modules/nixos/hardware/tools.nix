{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.hardware.tools;
in
with lib;
{
  options.modules.hardware.tools.enable = mkEnableOption "Hardware debugging tools";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lshw
      pciutils
      smartmontools
      nvme-cli
      usbutils
    ];
  };
}
