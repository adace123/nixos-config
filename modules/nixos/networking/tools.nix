{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.sys.networking.tools;
in
  with lib; {
    options.modules.sys.networking.tools.enable = mkEnableOption "Networking tools";

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        bmon
        dnsutils
        tcpdump
        termshark
        xh
      ];
    };
  }
