{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.security.yubikey;
in
with lib;
{
  options.adace.system.security.yubikey.enable = mkEnableOption "yubikey";
  config = mkIf cfg.enable {
    services = {
      pcscd.enable = true;
      udev.packages = [ pkgs.yubikey-personalization ];
      yubikey-agent.enable = true;
      udev.extraRules = # udev
        ''
          ACTION=="remove", ENV{ID_MODEL_ID}=="0407", ENV{ID_VENDOR_ID}=="1050", RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
        '';
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    environment.systemPackages = with pkgs; [
      pam_u2f
      yubikey-manager
    ];

    security.pam.u2f = {
      enable = true;
      settings.cue = true;
      control = "sufficient";
    };

    security.pam.services = {
      greetd.u2fAuth = true;
      sudo.u2fAuth = true;
      hyprlock.u2fAuth = true;
      login.u2fAuth = true;
    };

  };
}
