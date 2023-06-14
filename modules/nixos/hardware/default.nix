{...}: {
  imports = [./boot ./disk ./networking ./peripherals ./graphics ./tools.nix];

  hardware.enableRedistributableFirmware = true;
}
