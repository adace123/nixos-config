{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.networking.tools;
in
with lib;
{
  options.adace.system.networking.tools.enable = mkEnableOption "Networking tools";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bmon
      dnsutils
      doggo
      ethtool
      tcpdump
      termshark
      xh
    ];
  };
}
