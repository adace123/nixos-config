{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh.enable = mkOption {
    description = "Enable SSH";
    default = true;
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };

    networking.firewall.allowedTCPPorts = [22];

    users.users.${config.user.name}.openssh.authorizedKeys.keys = config.user.sshKeys;
  };
}
