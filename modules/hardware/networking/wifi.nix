{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.sys.networking.wifi;
in {
  options.sys.networking.wifi.enable = mkEnableOption "wifi";

  config = mkIf cfg.enable {
    sops.secrets.wireless = {
      sopsFile = ../../secrets/secrets.yaml;
      mode = "0440";
    };
    networking.wireless = {
      enable = true;
      environmentFile = config.sops.secrets.wireless.path;
      networks = {
        "Rexford Eero" = {
          psk = "@EERO@";
        };
      };
      userControlled.enable = true;
    };
  };
}
