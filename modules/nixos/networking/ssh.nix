{
  lib,
  config,
  host,
  options,
  ...
}:
with lib; let
  cfg = config.modules.networking.ssh;
in {
  options.modules.networking.ssh = {
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

    programs.ssh = {
      knownHosts = {
        github = {
          hostNames = ["github.com"];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [22];

    users.users.${config.modules.user.name}.openssh.authorizedKeys.keys = [
      (builtins.readFile ../../../hosts/${host}/${host}.pub)
    ];
  };
}
