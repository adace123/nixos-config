{
  config,
  lib,
  pkgs,
  ...
}: {
  system.build = {
    system-install = pkgs.nuenv.mkScript {
      name = "system-install";
      script = ''
        def generate_luks_key [] {
          echo "Generating LUKS key file"
          ${pkgs.openssl}/bin/openssl genrsa -out keyfile.bin
          chmod -v 000 keyfile.bin
          cryptsetup luksAddKey /dev/disk/by-partlabel/primary --key-file=/tmp/cryptroot.key keyfile.bin
          mkdir /mnt/boot/initrd
          mv keyfile.bin /mnt/boot/initrd/keyfile.bin
        }

        # run disko script
        def main [] {
          let password = (input -s "LUKS password: ")
          let password2 = (input -s "\nConfirm LUKS password: ")
          if $password != $password2 {
            echo "\nError: Passwords don't match"
            exit 1
          }
          $password | save -f "/tmp/cryptroot.key"

          echo "Formatting drive"
          let-env NIXOS_INSTALL_MODE = "1"
          let-env NIXPKGS_ALLOW_UNFREE = "1"
          ${config.system.build.diskoScript}
          echo "Done formatting"

          generate_luks_key

          # echo "Copying SSH key pair"
          mkdir /mnt/etc/ssh
          # cp /tmp/id_ed25519 /mnt/etc/ssh/ssh_host_ed25519_key
          # ssh-keygen -yf /mnt/etc/ssh/ssh_host_ed25519_key | save -f "/mnt/etc/ssh/ssh_host_ed25519_key"

          echo "Installing NixOS"
          nixos-install --root /mnt --system ${config.system.build.toplevel} --no-root-password
        }
      '';
    };
  };
}
