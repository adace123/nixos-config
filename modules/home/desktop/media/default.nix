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
    imports = [./cava.nix];
    config = mkIf cfg.enable {
      home.packages = [pkgs.playerctl];
    };
  }
