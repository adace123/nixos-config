{
  config,
  lib,
  ...
}: {
  modules = {
    window-manager.hyprland.enable = true;

    networking = {
      wifi.enable = true;
      tailscale.enable = true;
      tools.enable = true;
    };
    hardware.tools.enable = true;
    graphics.nvidia.enable = true;
    sound.enable = true;
    bluetooth.enable = true;
    boot.device = "/dev/sda";
    virtualisation = {
      podman.enable = true;
    };
    monitoring = {
      tools.enable = true;
    };
  };

  networking = {
    interfaces.wlp10s0 = {
      useDHCP = true;
      ipv4.addresses = [
        {
          address = "192.168.5.10";
          prefixLength = 24;
        }
      ];
    };
  };

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  user = {
    name = "aaron";
    sudo = true;
    sshKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINeg6I1BsevUn9zYaYrwLg5l2UKzPqlxn2Q68cs37CyV"];
  };

  # TODO: use sops-nix hm module once https://github.com/Mic92/sops-nix/issues/287 is fixed
  sops.secrets = {
    github-private-key = {
      sopsFile = ./secrets.yaml;
      owner = config.user.name;
    };
  };
}
