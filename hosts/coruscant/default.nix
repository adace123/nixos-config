{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  desktop = {
    enable = true;
  };

  sys = {
    networking = {
      wifi.enable = true;
      tailscale.enable = true;
    };
    graphics.nvidia.enable = true;
    sound.enable = true;
  };

  networking = {
    hostName = "coruscant";
    nameservers = ["192.168.4.1"];
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

  user = {
    name = "aaron";
    sudo = true;
    sshKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINeg6I1BsevUn9zYaYrwLg5l2UKzPqlxn2Q68cs37CyV"];
  };
}
