{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.system.security."1password";
in
with lib;
{
  options.adace.system.security."1password".enable = mkEnableOption "1password";
  config = mkIf cfg.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [
        "aaron"
      ];
    };

    environment.etc."1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
        zen-bin
        floorp
      '';
      mode = "0755";
    };
  };
}
