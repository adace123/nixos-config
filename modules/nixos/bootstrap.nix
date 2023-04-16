{
  config,
  lib,
  pkgs,
  ...
}: {
  system.build = {
    generate-luks-key = pkgs.nuenv.mkScript {
      name = "generate-luks-key";
      script = ''
        def main [--path: string] {
          echo "Generating LUKS key file"
          ${pkgs.openssl}/bin/openssl genrsa -out keyfile.bin
          chmod -v 000 keyfile.bin
          cryptsetup luksAddKey /dev/disk/by-partlabel/primary --key-file=/tmp/cryptroot.key keyfile.bin
          mkdir -p /mnt/boot/initrd
          mv keyfile.bin /mnt/boot/initrd/keyfile.bin
        }
      '';
    };

    system-install = pkgs.nuenv.mkScript {
      name = "system-install";
      script = ''
        # run disko script
        def main [--generate_luks_key] {
          let password = (input -s "LUKS password: ")
          let password2 = (input -s "\nConfirm LUKS password: ")
          if $password != $password2 {
            echo "\nError: Passwords don't match"
            exit 1
          }
          $password | save -f "/tmp/cryptroot.key"

          ${config.system.build.disko}
          if $generate_luks_key {
            ${config.system.build.generate-luks-key}
          }
          #
          echo "Installing NixOS"
          nixos-install --root /mnt --system ${config.system.build.toplevel}
        }
      '';
  };
  };

}
