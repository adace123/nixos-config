{ config, lib, ... }:
let
  cfg = config.adace.programs.terminal.tools.direnv;
in
with lib;
{
  options.adace.programs.terminal.tools.direnv.enable = mkEnableOption "direnv";
  config = mkIf cfg.enable { programs.direnv.enable = true; };
}
