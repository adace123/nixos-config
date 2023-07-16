{
  config,
  lib,
  ...
}: let
  cfg = config.modules.ssh;
in
  with lib; {
    options.modules.ssh = mkEnableOption "SSH user config";
    config = mkIf cfg.enable {
      programs.ssh = {
        enable = true;
        startAgent = true;
      };
    };
  }
