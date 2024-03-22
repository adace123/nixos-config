{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.monitoring.tools;
in
  with lib; {
    options.modules.monitoring.tools.enable = mkEnableOption "Monitoring tools";
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        bcc
        bpftool
        bpftrace
        s-tui
        kmon
      ];
    };
  }
