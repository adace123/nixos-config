_: {
  imports = [ ../coruscant-minimal ];
  adace.suites.system = {
    desktop.enable = true;
    peripherals.enable = true;
  };
  adace.system = {
    networking.tailscale.enable = true;
    graphics.nvidia.enable = true;
  };
}
