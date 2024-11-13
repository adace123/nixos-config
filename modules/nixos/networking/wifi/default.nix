{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.adace.system.networking.wifi;
in
{
  options.adace.system.networking.wifi = {
    enable = mkEnableOption "Enable wifi";
    setupProfiles = mkEnableOption "Create default NetworkManager profiles";
  };

  config = mkIf cfg.enable {
    sops.secrets = mkIf cfg.setupProfiles {
      wifi-ssid = { };
      wifi-password = { };
    };

    # sops.templates."home-wifi.env" = mkIf cfg.setupProfiles {
    #   owner = "root";
    #   content = ''
    #     HOME_WIFI_SSID = ${config.sops.placeholder.wifi-ssid}
    #     HOME_WIFI_PSK = ${config.sops.placeholder.wifi-password}
    #   '';
    # };

    networking.wireless.enable = false;
    networking.networkmanager = {
      wifi.backend = "iwd";
      ensureProfiles = mkIf cfg.setupProfiles {
        # environmentFiles = [ config.sops.templates."home-wifi.env".path ];
        # profiles.home-wifi = {
        #   ipv4.method = "auto";
        #   connection = {
        #     id = "home-wifi";
        #     type = "wifi";
        #     autoconnect = true;
        #   };
        #   wifi = {
        #     mac-address-blacklist = "";
        #     mode = "infrastructure";
        #     ssid = "$HOME_WIFI_SSID";
        #   };
        #   wifi-security = {
        #     auth-alg = "open";
        #     key-mgmt = "wpa-psk";
        #     psk = "$HOME_WIFI_PSK";
        #   };
        # };
      };
    };
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
