{
  config,
  lib,

  ...
}:
let
  cfg = config.adace.programs.terminal.tools.atuin;
in
with lib;
{
  options.adace.programs.terminal.tools.atuin.enable = mkEnableOption "atuin";
  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
