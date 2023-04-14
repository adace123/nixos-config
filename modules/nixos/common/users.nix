{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.primary-user;
in {
  options = {
    primary-user.name = mkOption {
      type = types.str;
      default = "aaron";
    };
    primary-user.sudo = mkEnableOption "sudo";
    primary-user.shell = mkOption {
        type = types.enum ["nushell" "bash" "zsh"];
        default = "nushell";
      };
  };

  config = {
    users = {
      mutableUsers = true;
      users.${cfg.name} = mkMerge [
        {
          isNormalUser = true;
          uid = 1000;
          shell = pkgs.${cfg.shell};
        }
        (mkIf cfg.sudo {
          extraGroups = ["wheel"];
        })
      ];
    };
  };
}
