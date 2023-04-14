{
  config,
  nixos-hardware,
  pkgs,
  overlays,
  inputs,
  ...
}: {
  imports = [./hardware-configuration.nix];
}
