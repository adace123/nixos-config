{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.security.yubikey;
in
with lib;
{
  options.adace.security.yubikey.enable = mkEnableOption "yubikey";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      yubikey-manager
      yubico-pam
    ];
  };
}
