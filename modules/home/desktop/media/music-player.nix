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
      programs.mpv = {
        enable = true;
        scripts = with pkgs.mpvScripts; [
          mpris
        ];
        config = {
          volume = 60;
        };
        bindings = {
          SPACE = "cycle pause";
          UP = "add volume 2";
          DOWN = "add volume -2";
          h = "seek -5";
          j = "seek -60";
          k = "seek 60";
          l = "seek 5";

          # rebind lost l binding, matches across from L which loops whole file
          H = "ab-loop";
          # rebind lost j binding, move J to K
          J = "cycle sub";
          K = "cycle sub down";
        };
      };
    };
  }
