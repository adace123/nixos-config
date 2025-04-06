{
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  adace.suites = {
    system.base.enable = true;
  };

  boot.loader.grub.enable = lib.mkForce false;

  # Cannot use sops-nix secrets in ISO
  adace.system.networking.wifi.setupProfiles = lib.mkForce false;
  adace.system.networking.dns.enable = true;
  adace.system.user.password.enable = false;

  users.users.root.openssh.authorizedKeys.keys = [ (builtins.readFile ./ssh.pub) ];

  isoImage = {
    isoName = lib.mkForce "nixos.iso";
    squashfsCompression = "gzip -Xcompression-level 1";
  };
}
