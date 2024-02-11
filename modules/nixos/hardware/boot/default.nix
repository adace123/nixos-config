{
  config,
  lib,
  options,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.boot;
in {
  options.modules.boot = {
    configLimit = mkOption {
      default = 5;
      description = "Boot configuration limit";
      type = types.int;
    };
    plymouth.enable = mkEnableOption "plymouth";
  };

  config = {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_6_7;
      loader.efi.canTouchEfiVariables = true;
      loader.grub = {
        enable = true;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
        useOSProber = true;
        configurationLimit = cfg.configLimit;
        theme = inputs.grub-theme;
      };
    };
  };
}
