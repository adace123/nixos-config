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
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        powerManagement.enable = true;
      };

      hardware.opengl.enable = true;

      environment.systemPackages = with pkgs; [nvitop cudaPackages.cuda_nvml_dev];

      boot.initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
      boot.kernelParams = [
        "clearcpuid=514" # Fixes certain wine games crash on launch
        "quiet"
        "splash"
        "boot.shell_on_fail"
      ];

      services.xserver.videoDrivers = ["nvidia"];
    };
  }
