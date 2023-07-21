{
  config,
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
    sops.secrets."${cfg.name}-password" = {
      neededForUsers = true;
    };

    users = {
      mutableUsers = false;
      defaultUserShell = pkgs.nushell;
      users.${cfg.name} = mkMerge [
        {
          isNormalUser = true;
          passwordFile = config.sops.secrets."${cfg.name}-password".path;
          openssh.authorizedKeys.keys = cfg.sshKeys;
        }
        (mkIf cfg.sudo {
          extraGroups = ["wheel"];
        })
      ];
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
