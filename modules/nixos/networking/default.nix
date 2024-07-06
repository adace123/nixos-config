{lib, ...}: {
  imports = [./ssh.nix ./avahi.nix ./tailscale.nix ./wifi.nix ./tailscale.nix ./tools.nix];

  services.resolved = {
    enable = lib.mkDefault true;
    dnssec = "false";
  };

  networking = {
    useDHCP = false;
    nameservers = ["192.168.4.1" "1.1.1.1" "8.8.8.8"];
    nftables.enable = true;
  };
}
