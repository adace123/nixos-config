{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.networking.tools;
in
  with lib; {
    options.modules.networking.tools.enable = mkEnableOption "Networking tools";

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        bmon
        dnsutils
        ethtool
        tcpdump
        termshark
        xh
      ];
    };
  }
