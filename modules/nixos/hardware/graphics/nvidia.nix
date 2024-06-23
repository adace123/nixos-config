{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.graphics.nvidia;
in
  with lib; {
    options.modules.graphics.nvidia.enable = mkEnableOption "Enable Nvidia";

    config = mkIf cfg.enable {
      hardware.nvidia = {
        # package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        powerManagement.enable = true;
      };

      hardware.graphics = {
        enable = true;
        driSupport32Bit = true;
        extraPackages = [pkgs.nvidia-vaapi-driver];
      };

      environment.systemPackages = with pkgs; [nvitop cudaPackages.cuda_nvml_dev];

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "nvidia";
        GBM_BACKEND = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        MOZ_DISABLE_RDD_SANDBOX = "1";
      };

      services.xserver = {
        videoDrivers = ["nvidia"];
        deviceSection = ''
          Option "DRI3" "on"
          Option "AllowSHMPixmaps" "on"
        '';
      };
    };
  }
