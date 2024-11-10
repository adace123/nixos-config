{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.user;
in
with lib;
{
  options.adace.system.user = {
    name = mkOption {
      type = types.str;
      description = "Default user name";
      default = "aaron";
    };
    password.enable = mkOption {
      type = types.bool;
      description = "Enable user password";
      default = true;
    };
    sudo.enable = mkOption {
      type = types.bool;
      description = "Enable sudo privileges";
      default = true;
    };
    extraGroups = mkOption {
      type = types.listOf types.str;
      description = "Extra user groups";
      default = [ ];
    };
  };

  config = {
    sops.secrets.password = mkIf cfg.password.enable {
      neededForUsers = true;
    };

    users = {
      mutableUsers = false;
      users.${cfg.name} = mkMerge [
        {
          isNormalUser = true;
          shell = pkgs.nushell;
          extraGroups = (optionals cfg.sudo.enable [ "wheel" ]) ++ cfg.extraGroups;
        }
        (mkIf cfg.password.enable {
          hashedPasswordFile = config.sops.secrets.password.path;
        })
      ];
    };

    security.sudo.enable = false;
    security.sudo-rs = mkIf cfg.sudo.enable {
      enable = true;
      wheelNeedsPassword = false;
    };

    # security.wrappers.sudo = mkIf cfg.sudo.enable {
    #   source = "${pkgs.sudo.out}/bin/sudo";
    #   owner = "root";
    #   group = "root";
    #   setuid = true;
    # };
  };
}
