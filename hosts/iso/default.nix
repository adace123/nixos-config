{
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  modules = {
    networking = {
      ssh = {
        enable = true;
        password = true;
      };
      wifi.enable = true;
      avahi.enable = true;
    };
    disko.enable = false;
    sops.enable = false;
  };

  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  user = {
    name = "nixos";
    sudo = true;
    sshKeys = [(builtins.readFile ./iso.pub)];
    usePassword = false;
  };

  users.users.nixos.initialPassword = "nixos";

  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
  systemd.services.wpa_supplicant.wantedBy = pkgs.lib.mkForce ["multi-user.target"];

  boot.loader.grub.enable = lib.mkForce true;

  isoImage.isoName = lib.mkForce "nixos.iso";
}
