{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.social.discord;
in
with lib;
{
  options.modules.desktop.social.discord.enable = mkEnableOption "discord";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.discord ];
  };
}
