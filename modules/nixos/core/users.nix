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
      name = mkOption {
        type = types.str;
        default = "root";
      };
      sudo = mkEnableOption "sudo";
      sshKeys = mkOption {
        type = types.listOf types.str;
        description = "List of user SSH keys";
        default = [];
      };
      usePassword = mkOption {
        type = types.bool;
        description = "Set user password";
        default = true;
      };
    };
  };

  config = {
    sops.secrets.password = mkIf cfg.usePassword {
      neededForUsers = true;
      sopsFile = ../../../hosts/${host}/secrets.yaml;
    };

    users = {
      mutableUsers = false;
      defaultUserShell = pkgs.nushell;
      users.${cfg.name} = mkMerge [
        {
          isNormalUser = true;
          openssh.authorizedKeys.keys = cfg.sshKeys;
        }
        (mkIf cfg.usePassword {
          hashedPasswordFile = config.sops.secrets.password.path;
        })
        (mkIf cfg.sudo {
          extraGroups = ["wheel"] ++ (optionals config.virtualisation.podman.enable ["podman"]);
        })
      ];
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
