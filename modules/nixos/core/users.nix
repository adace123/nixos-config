{
  config,
  host,
  options,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.user;
in {
  options.modules.user = {
    name = mkOption {
      type = types.str;
      description = "Default user name";
    };
    password.enable = mkEnableOption "Set user password";
    sudo.enable = mkEnableOption "Enable sudo privileges";
  };

  config = {
    sops.secrets.password = mkIf cfg.password.enable {
      neededForUsers = true;
      sopsFile = ../../../hosts/${host}/secrets.yaml;
    };

    users = {
      mutableUsers = false;
      users.${cfg.name} = mkMerge [
        {
          isNormalUser = true;
          shell = pkgs.nushell;
          extraGroups =
            (optionals cfg.sudo.enable ["wheel"])
            ++ (optionals config.virtualisation.podman.enable ["podman"])
            ++ (optionals config.modules.virtualisation.qemu.enable ["libvirtd"]);
        }
        (mkIf cfg.password.enable {
          hashedPasswordFile = config.sops.secrets.password.path;
        })
      ];
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
