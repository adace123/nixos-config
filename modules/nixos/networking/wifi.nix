{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.networking.wifi;
in
{
  options.modules.networking.wifi.enable = mkEnableOption "wifi";

  config = mkIf cfg.enable {
    # sops.secrets.wireless = {
    #   mode = "0440";
    #   path = "/var/lib/misc/wifi-password.txt";
    # };
    # networking.wireless = {
    #   enable = true;
    #   environmentFile = config.sops.secrets.wireless.path;
    #   networks = {
    #     "Rexford Eero" = {
    #       psk = "@EERO@";
    #     };
    #   };
    #   userControlled.enable = true;
    # };
    networking.wireless.enable = false;
    networking.networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
