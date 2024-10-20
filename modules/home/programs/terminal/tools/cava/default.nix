{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.cava;
in
with lib;
{
  options.adace.programs.terminal.tools.cava = mkEnableOption "cava";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.cava ];
  };
}
