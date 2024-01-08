{...}: {
  imports = [./boot ./disk ./peripherals ./graphics ./tools.nix];

  hardware.enableRedistributableFirmware = true;
}
