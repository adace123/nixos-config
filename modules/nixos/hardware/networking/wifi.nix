{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.networking.wifi;
in {
  options.modules.networking.wifi.enable = mkEnableOption "wifi";

  config = mkIf cfg.enable {
    sops.secrets.wireless = {
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
