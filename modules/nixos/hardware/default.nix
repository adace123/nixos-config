{...}: {
  imports = [./boot ./disk ./networking ./peripherals];

  hardware.enableRedistributableFirmware = true;
}
