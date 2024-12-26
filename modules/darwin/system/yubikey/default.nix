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

    system.activationScripts.postActivation.text = ''
      # shellcheck disable=SC2174
      mkdir -p -m 0755 /usr/local/lib/pam
      ln -svf ${pkgs.yubico-pam}/lib/security/pam_yubico.so /usr/local/lib/pam/pam_yubico.so
      ${pkgs.gnused}/bin/sed -i '2iauth sufficient pam_yubico.so mode=challenge-response' /etc/pam.d/sudo
    '';
  };
}
