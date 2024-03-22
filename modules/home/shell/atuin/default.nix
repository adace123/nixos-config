{
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.atuin;
in
  with lib; {
    options.modules.shell.atuin.enable = mkEnableOption "atuin";
    config = mkIf cfg.enable {
      programs.atuin = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
  }
