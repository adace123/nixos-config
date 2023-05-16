{
  config,
  lib,
  ...
}: let
  cfg = config.sys.graphics.nvidia;
in
  with lib; {
    options.sys.graphics.nvidia.enable = mkEnableOption "Enable Nvidia";
    config = mkIf cfg.enable {
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        powerManagement.enable = true;
      };
      hardware.opengl.enable = true;
    };
  }
