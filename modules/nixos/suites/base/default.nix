{ config, lib, ... }:
let
  cfg = config.adace.suites.system.base;
in
with lib;
{
  imports = [
    (snowfall.fs.get-file "modules/shared/suites/common/default.nix")
  ];
  options.adace.suites.system.base.enable = mkEnableOption "Enable base NixOS config";
  config = mkIf cfg.enable {
    system.stateVersion = "24.11";
    adace.suites.common.enable = true;
    adace.system = {
      boot.enable = true;
      nix.enable = true;
      networking = {
        network-manager.enable = true;
        dns.enable = true;
        ssh.enable = true;
        wifi = {
          enable = true;
          setupProfiles = true;
        };
      };
    };
  };
}
