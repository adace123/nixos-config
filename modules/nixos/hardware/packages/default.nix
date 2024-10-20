{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.packages;
in
with lib;
{
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
