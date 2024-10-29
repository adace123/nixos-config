{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.terminal.tools.ssh;
in
with lib;
{
  options.adace.terminal.tools.ssh.enable = mkEnableOption "SSH user config";
  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
    };

    home.file.".ssh/known_hosts".text = ''
      github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
    '';
  };
}
