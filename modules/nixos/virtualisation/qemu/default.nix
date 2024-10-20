{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.virtualisation.qemu;
in
with lib;
{
  options.adace.system.virtualisation.qemu.enable = mkEnableOption "qemu";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libvirt
      qemu
      virt-viewer
    ];
    environment.sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";
    users.users.${snowfallorg.user.name}.extraGroups = [ "libvirtd" ];
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
  };
}
