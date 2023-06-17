{lib, ...}: {
  imports = [./ssh.nix ./tailscale.nix ./tools.nix];

  services.resolved = {
    enable = lib.mkDefault true;
    dnssec = "false";
  };
}
