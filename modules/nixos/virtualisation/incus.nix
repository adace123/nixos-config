{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.virtualisation.incus;
  user = config.modules.user;
in
with lib;
{
  options.modules.virtualisation.incus.enable = mkEnableOption "qemu";
  config = mkIf cfg.enable {
    users.users.${user.name}.extraGroups = [ "incus-admin" ];
    networking.firewall.trustedInterfaces = [ "incusbr0" ];
    virtualisation.incus = {
      enable = true;
      preseed = {
        networks = [
          {
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat" = "true";
            };
            name = "incusbr0";
            type = "bridge";
          }
        ];
        profiles = [
          {
            devices = {
              eth0 = {
                name = "eth0";
                network = "incusbr0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                size = "35GiB";
                type = "disk";
              };
            };
            name = "default";
          }
        ];
        storage_pools = [
          {
            config = {
              source = "/var/lib/incus/storage-pools/default";
            };
            driver = "dir";
            name = "default";
          }
        ];
      };
    };
  };
}
