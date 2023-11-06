{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.zig;
in
  with lib; {
    options.modules.dev.zig.enable = mkEnableOption "zig";
    config = mkIf cfg.enable {
      home.packages =
        optionals (!nvim_cfg.enable) [pkgs.zig];
    };
  }
