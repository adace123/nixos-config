{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.languages.zig;
in
with lib;
{
  options.adace.development.languages.zig.enable = mkEnableOption "Enable Zig tools";
  config = mkIf cfg.enable { home.packages = [ pkgs.zig ]; };
}
