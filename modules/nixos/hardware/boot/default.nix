{
  config,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  inherit (config.modules.boot) configLimit plymouthEnable;
in {
  options.modules.boot = {
    configLimit = mkOption {
      default = 5;
      description = "Boot configuration limit";
      type = types.int;
    };
    plymouthEnable = mkEnableOption "plymouth";
  };

  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader.efi.canTouchEfiVariables = true;
      loader.grub = {
        enable = true;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
        configurationLimit = configLimit;
      };
      initrd = {
        luks.devices."cryptroot" = {
          allowDiscards = true;
          bypassWorkqueues = true;
          fallbackToPassword = true;
          keyFile = "/cryptroot.key";
        };
        secrets = {
          "/cryptroot.key" = "/cryptroot.key";
        };
      };
      plymouth = {
        enable = plymouthEnable;
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
