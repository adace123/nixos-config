{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.adace.system.monitoring;
in
{
  options.adace.system.monitoring.enable = mkEnableOption "prometheus";
  config = mkIf cfg.enable {
    services.prometheus = {
      exporters = {
        node = {
          enable = true;
          listenAddress = "127.0.0.1";
          port = 9090;
          enabledCollectors = [
            "systemd"
            "textfile"
          ];
          extraFlags = [
            "--collector.textfile.directory /etc/prometheus/textfile/"
          ];
        };
        smartctl = {
          enable = true;
          listenAddress = "127.0.0.1";
          port = 9091;
        };
      };
    };
  };
}
