{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.ssh;
in
with lib;
{
  options.adace.programs.terminal.tools.ssh.enable = mkEnableOption "SSH user config";
  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      knownHosts = {
        github = {
          hostNames = [ "github.com" ];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        };
      };
    };
  };
}
