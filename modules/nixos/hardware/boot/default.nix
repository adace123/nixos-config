{
  config,
  lib,
  options,
  pkgs,
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
        configurationLimit = cfg.configLimit;
      };
      initrd = {
        # luks.devices."cryptroot" = {
        # allowDiscards = true;
        # bypassWorkqueues = true;
        # fallbackToPassword = true;
        # keyFile = "/cryptroot.key";
        # };
        secrets = {
          "/cryptroot.key" = "/cryptroot.key";
        };
      };
      plymouth = {
        inherit (cfg.plymouth) enable;
        theme = "catppuccin-mocha";
        themePackages = [
          (pkgs.catppuccin-plymouth.override {
            variant = "mocha";
          })
        ];
      };
    };
  };
}
