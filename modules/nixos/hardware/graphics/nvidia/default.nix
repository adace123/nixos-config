{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.graphics.nvidia;
in
with lib;
{
  options.adace.system.graphics.nvidia.enable = mkEnableOption "Enable Nvidia";

  config = mkIf cfg.enable {
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.nvidia-vaapi-driver ];
    };

    environment.systemPackages = with pkgs; [
      nvitop
      cudaPackages.cuda_nvml_dev
    ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = "1";
    };

    services.xserver = {
      videoDrivers = [ "nvidia" ];
      deviceSection = ''
        Option "DRI3" "on"
        Option "AllowSHMPixmaps" "on"
      '';
    };
  };
}
