{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.media;
in
with lib;
{
  config = mkIf cfg.enable {
    home.packages = [ pkgs.cava ];
  };
}
