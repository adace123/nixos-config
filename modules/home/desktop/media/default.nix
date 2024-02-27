{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.media;
in
  with lib; {
    options.modules.desktop.media.enable = mkEnableOption "media";
    imports = [./cava.nix ./mpv.nix];
    config = mkIf cfg.enable {
      services.playerctld.enable = true;
      home.packages = [pkgs.playerctl];
    };
  }
