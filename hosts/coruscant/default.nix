{
  config,
  lib,
  ...
}: {
  imports = [./disk.nix];
  modules = {
    user = {
      name = "aaron";
      password.enable = true;
      sudo.enable = true;
    };
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
    boot = {
      plymouth.enable = true;
    };
    virtualisation = {
      podman.enable = true;
    };
    monitoring = {
      tools.enable = true;
    };
  };

  networking = {
    defaultGateway = "192.168.4.1";
    interfaces.enp11s0.wakeOnLan.enable = true;
    extraHosts = ''
      192.168.4.90 proxmox.homelab
    '';
    interfaces.wlp10s0 = {
      useDHCP = true;
      ipv4.addresses = [
        {
          address = "192.168.4.10";
          prefixLength = 32;
        }
      ];
      ipv4.routes = [
        {
          address = "192.168.4.90";
          prefixLength = 32;
        }
      ];
    };
  };

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # TODO: use sops-nix hm module once https://github.com/Mic92/sops-nix/issues/287 is fixed
  sops.secrets = {
    github-private-key = {
      sopsFile = ./secrets.yaml;
      owner = config.modules.user.name;
    };
    proxmox-private-key = {
      sopsFile = ./secrets.yaml;
      owner = config.modules.user.name;
    };
  };
}
