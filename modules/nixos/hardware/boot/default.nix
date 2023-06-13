{
  config,
  lib,
  options,
  modulesPath,
  pkgs,
  ...
}:
with lib; let
  inherit (config.modules.sys.boot) configLimit;
in {
  options.modules.sys.boot.configLimit = mkOption {
    default = 5;
    description = "Boot configuration limit";
    type = types.int;
  };

  config = {
    boot.loader.efi = {
      canTouchEfiVariables = true;
    };

    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      enableCryptodisk = true;
      device = "nodev";
      configurationLimit = configLimit;
    };

    boot.initrd = {
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
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
