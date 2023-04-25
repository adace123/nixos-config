{...}: {
  imports = [./wifi.nix];

  networking = {
    useDHCP = false;
    nameservers = ["192.168.4.1"];
  };
}
