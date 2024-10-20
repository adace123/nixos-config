{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.system.security.sops;
in
with lib;
{
  options.adace.system.security.sops.enable = mkEnableOption "sops-nix";
  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = snowfall.fs.get-file "modules/nixos/secrets.yaml";
      age.sshKeyPaths = [ "/etc/ssh/sops-nix" ];
    };
  };
}
