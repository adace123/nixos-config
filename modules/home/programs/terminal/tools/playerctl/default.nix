{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.playerctl;
in
with lib;
{
  options.adace.programs.terminal.tools.playerctl.enable = mkEnableOption "media";
  config = mkIf cfg.enable {
    services.playerctld.enable = true;
    home.packages = [ pkgs.playerctl ];
  };
}
