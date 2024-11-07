{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.suites.virtualisation;
in
with lib;
{
  options.adace.suites.virtualisation = mkEnableOption "virtualization";
  config = mkIf cfg.enable {
    adace.system.virtualisation = {
      incus.enable = true;
      podman.enable = true;
      qemu.enable = true;
    };
  };
}
