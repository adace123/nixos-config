{
  lib,
  modulesPath,
  ...
}:
{
  adace.suites = {
    system.base.enable = true;
  };

  boot.loader.grub.enable = lib.mkForce false;

  # Cannot use sops-nix secrets in ISO
  adace.system.networking.wifi.setupProfiles = lib.mkForce false;

  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  users.users.nixos.openssh.authorizedKeys.keys = [ (builtins.readFile ./iso.pub) ];

  isoImage = {
    isoName = lib.mkForce "nixos.iso";
    squashfsCompression = "gzip -Xcompression-level 1";
  };

  # Cannot use NetworkManager config in ISO since it requires sops-nix secrets
  networking.networkmanager.enable = lib.mkForce false;
  networking.wireless.enable = lib.mkForce true;
}
