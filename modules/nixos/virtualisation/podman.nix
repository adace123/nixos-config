{
  config,
  lib,
  ...
}: let
  cfg = config.modules.virtualisation.podman;
  user = config.modules.user;
in
  with lib; {
    options.modules.virtualisation.podman.enable = mkEnableOption "podman";
    config = mkIf cfg.enable {
      environment.sessionVariables.DOCKER_HOST = "unix:///run/podman/podman.sock";
      users.users.${user.name}.extraGroups = ["podman"];
      virtualisation.podman = {
        enable = true;
        autoPrune.enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  }
