{
  config,
  lib,
  pkgs,
  ...
}: let
  disko = pkgs.writeShellScriptBin "disko" ''${config.system.build.disko}'';
  disko-mount = pkgs.writeShellScriptBin "disko-mount" "${config.system.build.mountScript}";
  disko-format = pkgs.writeShellScriptBin "disko-format" "${config.system.build.formatScript}";
  install-system = pkgs.writeShellScriptBin "install-system" ''
    set -euo pipefail

    echo "Formatting disks..."
    ${disko-format}/bin/disko-format

    echo "Mounting disks..."
    ${disko-mount}/bin/disko-mount

    echo "Installing system..."
    nixos-install --system x86_64-linux

    echo "Done!"
  '';
in {
  disko.enableConfig = lib.mkDefault false;

  environment.systemPackages = [
    disko
    disko-mount
    disko-format
    install-system
  ];

}
