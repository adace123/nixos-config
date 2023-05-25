{...}: {
  imports = [./boot ./disk ./networking ./peripherals ./graphics];

  hardware.enableRedistributableFirmware = true;
}
