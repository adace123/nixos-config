{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.hardware.networking.wifi;
in {
  options.modules.hardware.networking.wifi.enable = mkEnableOption "wifi";

  config = mkIf cfg.enable {
    sops.secrets.wireless = {
      sopsFile = ../../common/secrets/secrets.yaml;
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
