{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/hardware/virtualization/qemu.nix
  ];

  modules.hardware.device = "/dev/vda";

  networking.hostName = "nixos-vm";
}
