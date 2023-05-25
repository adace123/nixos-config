{lib, ...}: {
  imports = [./ssh.nix ./tailscale.nix];

  services.resolved = {
    enable = lib.mkDefault true;
    dnssec = "false";
  };
}
