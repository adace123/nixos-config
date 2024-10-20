{ config, lib, ... }:
let
  cfg = config.adace.system.networking.network-manager;
in
with lib;
{
  options.adace.system.networking.network-manager.enable = mkEnableOption "network-manager";

  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        connectionConfig = {
          "connection.mdns" = 2;
        };
      };
    };
  };
}
