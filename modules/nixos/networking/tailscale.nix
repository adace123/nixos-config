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
      };

      systemd.services.tailscale-autoconnect = {
        description = "Automatic connection to Tailscale";

        after = ["network-pre.target" "tailscale.service"];
        wants = ["network-pre.target" "tailscale.service"];
        wantedBy = ["multi-user.target"];

        serviceConfig.Type = "oneshot";

        script = with pkgs; ''
          # wait for tailscaled to settle
          sleep 2

          # check if we are already authenticated to tailscale
          status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
          if [ $status = "Running" ]; then # if so, then do nothing
            exit 0
          fi

          # otherwise authenticate with tailscale
          ${tailscale}/bin/tailscale up -authkey "file:${config.sops.secrets.tailscale-auth-key.path}"
        '';
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
