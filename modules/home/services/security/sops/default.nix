{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.services.sops;
in
with lib;
{
  options.adace.services.sops.enable = mkEnableOption "sops";
  config = mkIf cfg.enable {
    # restart sops-nix user service to pick up latest changes to secrets
    # TODO: Can something similar be implemented for darwin machines?
    home.activation = lib.mkIf pkgs.stdenv.isLinux {
      restartSops = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        /run/current-system/sw/bin/systemctl start --user sops-nix
      '';
    };

    home.packages = with pkgs; [ sops ];

    sops = {
      defaultSopsFile = snowfall.fs.get-file "modules/home/secrets.yaml";
      age = {
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        sshKeyPaths = [ "${builtins.getEnv "HOME"}/.ssh/id_ed25519" ];
      };
    };
  };
}
