{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.social.discord;
in
with lib;
{
  options.adace.desktop.social.discord.enable = mkEnableOption "discord";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.discord ];
  };
}
