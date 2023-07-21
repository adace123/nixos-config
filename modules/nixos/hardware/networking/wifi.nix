{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.sys.networking.wifi;
in {
  options.modules.sys.networking.wifi.enable = mkEnableOption "wifi";

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
