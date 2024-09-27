{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.yazi;
in
with lib;
{
  options.adace.programs.terminal.tools.yazi.enable = mkEnableOption "Yazi";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.ueberzugpp ];
    programs.yazi = {
      enable = true;
    };
  };
}
