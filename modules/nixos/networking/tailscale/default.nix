{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.adace.system.networking.tailscale;
in
with pkgs;
with lib;
{
  options.adace.system.networking.tailscale.enable = mkEnableOption "tailscale";

  config = mkIf cfg.enable {
    environment.systemPackages = [ tailscale ];

    services.tailscale = {
      enable = true;
      interfaceName = "tailscale0";
      port = 41641;
      extraUpFlags = [
        "--ssh"
        "--advertise-tags=tag:nixos-machine"
      ];
      authKeyFile = config.sops.secrets.tailscale-auth-key.path;
    };

    networking = {
      firewall = {
        trustedInterfaces = [ "tailscale0" ];
        checkReversePath = "loose";
        allowedUDPPorts = [ config.services.tailscale.port ];
        allowedTCPPorts = [ 22 ];
      };
      nameservers = [ "100.100.100.100" ];
      networkmanager.unmanaged = [ "tailscale0" ];
    };

    sops.secrets.tailscale-auth-key = {
      restartUnits = [ "tailscaled.service" ];
    };

    systemd.network.wait-online.ignoredInterfaces = [ "tailscale0" ];
    systemd.services.tailscaled.after = [ "NetworkManager-wait-online.service" ];
  };
}
