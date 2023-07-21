{
  config,
  lib,
  ...
}: let
  cfg = config.modules.ssh;
in
  with lib; {
    options.modules.ssh.enable = mkEnableOption "SSH user config";
    config = mkIf cfg.enable {
      programs.ssh = {
        enable = true;
      };
    };
  }
