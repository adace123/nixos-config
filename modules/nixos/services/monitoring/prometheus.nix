{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.prometheus;
in {
  options.modules.services.prometheus.enable = mkEnableOption "prometheus";
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9090;
      retentionTime = "7d";
      globalConfig = {
        scrape_interval = "30s";
        evaluation_interval = "30s";
      };
    };
  };
}
