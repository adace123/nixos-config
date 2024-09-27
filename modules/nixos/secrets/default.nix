{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.networking.hostName != "iso") {
    sops = {
      defaultSopsFile = ../secrets.yaml;
      age.sshKeyPaths = [ "/etc/ssh/sops-nix" ];
    };
  };
}
