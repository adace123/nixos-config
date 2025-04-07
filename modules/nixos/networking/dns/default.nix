{ config, lib, ... }:
let
  cfg = config.adace.system.networking.dns;
in
with lib;
{
  options.adace.system.networking.dns.enable = mkEnableOption "DNS";
  config = mkIf cfg.enable {
    services.resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      extraConfig = ''
        Domains=~.
        DNS=127.0.0.1
        MulticastDNS=true
        DNSStubListener=yes
      '';
    };

    networking = {
      nameservers = [
        "127.0.0.53"
        "192.168.4.1"
        "1.1.1.1"
        "8.8.8.8"
      ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish.enable = true;
      publish.addresses = true;
      publish.workstation = true;
    };

    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        require_dnssec = true;
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };

    systemd.services.dnscrypt-proxy2.serviceConfig = {
      StateDirectory = "dnscrypt-proxy";
    };

  };
}
