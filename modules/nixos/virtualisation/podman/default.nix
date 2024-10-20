{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.system.virtualisation.podman;
in
with lib;
{
  options.adace.system.virtualisation.podman.enable = mkEnableOption "podman";
  config = mkIf cfg.enable {
    environment.sessionVariables.DOCKER_HOST = "unix:///run/podman/podman.sock";
    users.users.${snowfallorg.user.name}.extraGroups = [ "podman" ];
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
        dates = "weekly";
      };
    };
  };
}
