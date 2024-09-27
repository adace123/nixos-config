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
    };
  };
}
