{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking.tailscale;
in
  with pkgs;
  with lib; {
    options.modules.networking.tailscale.enable = mkEnableOption "tailscale";

    config = mkIf cfg.enable {
      environment.systemPackages = [tailscale];

      services.tailscale = {
        enable = true;
        interfaceName = "tailscale0";
        port = 41641;
        extraUpFlags = ["--ssh"];
        authKeyFile = config.sops.secrets.tailscale-auth-key.path;
      };

      networking.firewall = {
        trustedInterfaces = ["tailscale0"];

        allowedUDPPorts = [config.services.tailscale.port];

        allowedTCPPorts = [22];
      };

      sops.secrets.tailscale-auth-key = {
        restartUnits = ["tailscale-autoconnect.service"];
      };
    };
  }
