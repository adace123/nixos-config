{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.go;
in
  with lib; {
    options.modules.dev.go.enable = mkEnableOption "go";
    config = mkIf cfg.enable {
      home.packages = [pkgs.go pkgs.gotools];
    };
  }
