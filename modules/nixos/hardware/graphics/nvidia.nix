{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.sys.graphics.nvidia;
in
  with lib; {
    options.modules.sys.graphics.nvidia.enable = mkEnableOption "Enable Nvidia";

    config = mkIf cfg.enable {
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        modesetting.enable = true;
        powerManagement.enable = true;
      };

      hardware.opengl.enable = true;

      environment.systemPackages = with pkgs; [nvitop cudaPackages.cuda_nvml_dev];

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "nvidia";
        GBM_BACKEND = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        MOZ_DISABLE_RDD_SANDBOX = "1";
      };

      services.xserver.videoDrivers = ["nvidia"];
    };
  }
