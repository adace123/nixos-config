{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.sys.hardware.tools;
in
  with lib; {
    options.modules.sys.hardware.tools.enable = mkEnableOption "Hardware debugging tools";

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        duf
        lshw
        pciutils
        smartmontools
        nvme-cli
      ];
    };
  }
