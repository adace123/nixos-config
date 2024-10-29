{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.tools.yazi;
in
with lib;
{
  options.adace.terminal.tools.yazi.enable = mkEnableOption "Yazi";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.ueberzugpp ];
    programs.yazi = {
      enable = true;
    };
  };
}
