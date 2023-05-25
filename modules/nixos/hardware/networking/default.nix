{...}: {
  imports = [./wifi.nix];

  networking = {
    useDHCP = false;
    nameservers = ["192.168.4.1" "1.1.1.1" "8.8.8.8"];
  };
}
