{...}: {
  imports = [./boot ./disk ./networking ./peripherals ./graphics ./bootstrap.nix];

  hardware.enableRedistributableFirmware = true;
}
