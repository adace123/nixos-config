{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.tools.cava;
in
with lib;
{
  options.adace.terminal.tools.cava.enable = mkEnableOption "cava";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.cava ];
  };
}
