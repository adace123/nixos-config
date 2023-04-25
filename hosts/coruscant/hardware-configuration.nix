{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  modules.hardware.device = "/dev/sda";

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
