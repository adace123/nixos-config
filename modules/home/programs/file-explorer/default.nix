{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.file-explorer;
in
  with lib; {
    options.modules.file-explorer.enable = mkEnableOption "file explorer";
    config = mkIf cfg.enable {
      home.packages = [pkgs.ueberzugpp];
      programs.yazi = {
        enable = true;
      };
    };
  }
