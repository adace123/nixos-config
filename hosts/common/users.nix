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
      shell = mkOption {
        type = types.enum ["nushell" "bash" "zsh"];
        default = "nushell";
      };
      sshKeys = mkOption {
        type = types.listOf types.str;
        description = "List of user SSH keys";
        default = [];
      };
    };
  };

  config = {
    sops.secrets."${cfg.name}-password" = {
      sopsFile = ../../modules/nixos/secrets/secrets.yaml;
      neededForUsers = true;
    };

    users = {
      mutableUsers = false;
      defaultUserShell = pkgs.${cfg.shell};

      users.${cfg.name} = mkMerge [
        {
          isNormalUser = true;
          passwordFile = config.sops.secrets."${cfg.name}-password".path;
        }
        (mkIf cfg.sudo {
          extraGroups = ["wheel"];
        })
      ];
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
