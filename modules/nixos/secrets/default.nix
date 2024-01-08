{
  lib,
  config,
  ...
}: let
  cfg = config.modules.sops;
in
  with lib; {
    options.modules.sops.enable = mkOption {
      type = types.bool;
      description = "Enable sops secrets";
      default = true;
    };

    config = mkIf cfg.enable {
      sops = {
        defaultSopsFile = ../../../hosts/secrets.yaml;
        age.sshKeyPaths = ["/etc/ssh/sops-nix"];
      };
    };
  }
