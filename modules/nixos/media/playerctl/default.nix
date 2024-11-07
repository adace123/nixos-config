{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.tools.playerctl;
in
with lib;
{
  options.adace.terminal.tools.playerctl.enable = mkEnableOption "media";
  config = mkIf cfg.enable {
    services.playerctld.enable = true;
    environment.systemPackages = [ pkgs.playerctl ];
  };
}
