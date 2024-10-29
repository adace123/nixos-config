{ config, lib, ... }:
let
  cfg = config.adace.terminal.tools.direnv;
in
with lib;
{
  options.adace.terminal.tools.direnv.enable = mkEnableOption "direnv";
  config = mkIf cfg.enable { programs.direnv.enable = true; };
}
