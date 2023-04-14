{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # TODO: Change device to correct name
  modules.hardware.device = "/dev/nvme01";

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
