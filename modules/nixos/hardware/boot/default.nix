{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.boot;
in
{
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
      kernelPackages = pkgs.linuxKernel.packages.linux_6_8;
      loader.efi.canTouchEfiVariables = true;
      loader.grub = {
        enable = true;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
        useOSProber = true;
        configurationLimit = cfg.configLimit;
        catppuccin.enable = true;
      };
    };
  };
}
