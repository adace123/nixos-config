{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.virtualisation.qemu;
in
  with lib; {
    options.modules.virtualisation.qemu.enable = mkEnableOption "qemu";
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [qemu virt-viewer];
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
