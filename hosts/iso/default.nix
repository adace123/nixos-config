{
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  modules = {
    networking = {
      ssh = {
        enable = true;
      };
      wifi.enable = true;
      avahi.enable = true;
    };
    user.name = "nixos";
  };

  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  users.users.root.openssh.authorizedKeys.keys = [ (builtins.readFile ./iso.pub) ];

  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  systemd.services.wpa_supplicant.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  boot.loader.grub.enable = lib.mkForce true;

  isoImage = {
    isoName = lib.mkForce "nixos.iso";
    squashfsCompression = "gzip -Xcompression-level 1";
  };
}
