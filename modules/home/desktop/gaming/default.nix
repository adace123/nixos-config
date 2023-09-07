{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.gaming;
in
  with lib; {
    options.config.modules.desktop.gaming.enable = mkEnableOption "gaming";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
      ];

      programs = {
        gamemode.enable = true;
        steam.enable = true;
        mangohud.enable = true;
      };
    };
  }
