{...}: {
  imports = [./boot ./peripherals ./graphics ./tools.nix];

  hardware.enableRedistributableFirmware = true;
}
