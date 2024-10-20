{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.monitoring.tools;
in
with lib;
{
  options.adace.system.monitoring.tools.enable = mkEnableOption "Monitoring tools";
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
