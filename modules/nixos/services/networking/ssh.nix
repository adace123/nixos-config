{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh.enable = mkEnableOption "ssh";
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      passwordAuthentication = false;
    };

    networking.firewall.allowedTCPPorts = [22];
  };
}
