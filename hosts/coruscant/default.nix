{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  modules.hardware.networking.wifi.enable = true;
  networking.hostName = "coruscant";

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

  user = {
    name = "aaron";
    sudo = true;
    sshKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINeg6I1BsevUn9zYaYrwLg5l2UKzPqlxn2Q68cs37CyV"];
  };
}