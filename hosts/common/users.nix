{
  config,
  host,
  options,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.user;
in {
  options = {
    user = {
      name = mkOption {type = types.str;};
      sudo = mkEnableOption "sudo";
      sshKeys = mkOption {
        type = types.listOf types.str;
        description = "List of user SSH keys";
        default = [];
      };
    };
  };

  config = {
    sops.secrets.password = {
      neededForUsers = true;
      sopsFile = ../../hosts/${host}/secrets.yaml;
    };

    users = {
      mutableUsers = false;
      defaultUserShell = pkgs.nushell;
      users.${cfg.name} = mkMerge [
        {
          isNormalUser = true;
          passwordFile = config.sops.secrets.password.path;
          openssh.authorizedKeys.keys = cfg.sshKeys;
        }
        (mkIf cfg.sudo {
          extraGroups = ["wheel"] ++ (optionals config.virtualisation.podman.enable ["podman"]);
        })
      ];
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
