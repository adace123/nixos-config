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
      yk_pam="auth sufficient pam_yubico.so mode=challenge-response"
      grep -qxF "$yk_pam" /etc/pam.d/sudo || sed -i "2i$yk_pam" /etc/pam.d/sudo
    '';
  };
}
