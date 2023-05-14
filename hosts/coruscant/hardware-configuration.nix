{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  config = {
    sys.boot.device = "/dev/sda";

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
