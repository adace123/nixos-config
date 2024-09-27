{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.languages.go;
in
with lib;
{
  options.adace.development.languages.go.enable = mkEnableOption "Enable go tooling";
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.go
      pkgs.gotools
    ];
  };
}
