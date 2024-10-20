{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.graphical.social.discord;
in
with lib;
{
  options.adace.programs.graphical.social.discord.enable = mkEnableOption "discord";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.discord ];
  };
}
