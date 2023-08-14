{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.media;
in
  with lib; {
    config = mkIf cfg.enable {
      home.packages = [pkgs.mpv];
      services.mpd.enable = true;
      services.mpd-mpris.enable = true;
    };
  }
