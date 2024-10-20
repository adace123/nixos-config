{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.adace.system.networking.ssh;
in
{
  options.adace.system.networking.ssh = {
    enable = mkOption {
      description = "Enable SSH";
      default = true;
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };

    # TODO: Replace with Tailscale SSH
    networking.firewall.allowedTCPPorts = [ 22 ];

    users.users.${config.adace.system.user.name}.openssh.authorizedKeys.keys = [
      (snowfall.fs.get-file "systems/x86_64-linux/${config.networking.hostName}/ssh.pub")
    ];
  };
}
