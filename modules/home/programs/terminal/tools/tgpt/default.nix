{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.tgpt;
in
with lib;
{
  options.adace.programs.terminal.tools.tgpt.enable = mkEnableOption "tgpt";
  config = mkIf cfg.enable { home.packages = [ pkgs.tgpt ]; };
}
