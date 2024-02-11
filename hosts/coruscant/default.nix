{
  config,
  lib,
  fullBuild,
  ...
}: {
  imports = [./disk.nix];
  modules = {
    user = {
      name = "aaron";
      password.enable = true;
      sudo.enable = true;
    };
    window-manager.hyprland.enable = fullBuild;

    networking = {
      wifi.enable = true;
      tailscale.enable = true;
      avahi.enable = true;
      tools.enable = fullBuild;
    };
    hardware.tools.enable = fullBuild;
    graphics.nvidia.enable = fullBuild;
    sound.enable = fullBuild;
    bluetooth.enable = fullBuild;
    boot = {
      plymouth.enable = true;
    };
    virtualisation = {
      podman.enable = fullBuild;
    };
    monitoring = {
      tools.enable = fullBuild;
    };
  };

  networking = {
    defaultGateway = "192.168.4.1";
    interfaces.enp11s0.wakeOnLan.enable = true;
    extraHosts = ''
      192.168.4.90 proxmox.homelab
    '';
    interfaces.wlan0 = {
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
