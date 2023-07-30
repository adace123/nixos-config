{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.modules.networking.ssh;
in {
  options.modules.networking.ssh.enable = mkOption {
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
