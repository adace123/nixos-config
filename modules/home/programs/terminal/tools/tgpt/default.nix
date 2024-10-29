{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.tools.tgpt;
in
with lib;
{
  options.adace.terminal.tools.tgpt.enable = mkEnableOption "tgpt";
  config = mkIf cfg.enable { home.packages = [ pkgs.tgpt ]; };
}
