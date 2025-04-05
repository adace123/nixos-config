{ config, lib, ... }:
let
  cfg = config.adace.suites.system.security;
in
with lib;
{
  options.adace.suites.system.security.enable = mkEnableOption "Enable security settings";
  config = mkIf cfg.enable {
    adace.system.security = {
      "1password".enable = true;
      sops.enable = true;
      tpm.enable = true;
      yubikey.enable = true;
    };
  };
}
