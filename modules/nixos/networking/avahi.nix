{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.networking.avahi;
in
with lib;
{
  options.modules.networking.avahi.enable = mkEnableOption "avahi";

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        workstation = true;
        userServices = true;
        addresses = true;
      };
    };
  };
}
