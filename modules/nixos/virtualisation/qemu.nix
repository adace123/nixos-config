{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.virtualisation.qemu;
  user = config.modules.user;
in
  with lib; {
    options.modules.virtualisation.qemu.enable = mkEnableOption "qemu";
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [libvirt qemu virt-viewer];
      environment.sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";
      users.users.${user.name}.extraGroups = ["libvirtd"];
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
        };
      };
    };
  }
