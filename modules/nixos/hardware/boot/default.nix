{
  config,
  lib,
  options,
  modulesPath,
  ...
}:
with lib; let
  inherit (config.modules.boot) configLimit;
in {
  options.modules.boot.configLimit = mkOption {
    default = 10;
    description = "Boot configuration limit";
    type = types.int;
  };

  config = {
    boot.loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    boot.loader.grub = {
      enable = true;
      version = 2;
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
  };
}
