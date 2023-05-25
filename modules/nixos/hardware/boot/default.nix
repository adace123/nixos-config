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
    default = 10;
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
    };

    boot.initrd = {
      luks.devices."cryptroot" = {
        allowDiscards = true;
        bypassWorkqueues = true;
        fallbackToPassword = true;
        keyFile = "/keyfile.bin";
      };
      secrets = {
        "/keyfile.bin" = "/boot/initrd/keyfile.bin";
      };
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
