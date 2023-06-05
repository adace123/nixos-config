
def generate_luks_key [] {
  echo "Generating LUKS key file"
  echo '>>> Generating LUKS key file...'
  dd bs=4096 count=1 iflag=fullblock if=/dev/random of="keyfile.bin"
  chmod 000 keyfile.bin
  cryptsetup luksAddKey /dev/disk/by-partlabel/primary --key-file=/tmp/cryptroot.key keyfile.bin
  mkdir /mnt/boot/initrd
  mv keyfile.bin /mnt/boot/initrd/keyfile.bin
}

# run disko script
def main [--host: string] {
  let password = (input -s "LUKS password: ")
  let password2 = (input -s "\nConfirm LUKS password: ")
  if $password != $password2 {
    echo "\nError: Passwords don't match"
    exit 1
  }
  $password | save "/tmp/cryptroot.key"
  # #
  echo "Formatting drive"
  # let-env NIXOS_INSTALL_MODE = "1"
  # let-env NIXPKGS_ALLOW_UNFREE = "1"
  #
  let disko = (nix build --no-link --print-out-paths $".#nixosConfigurations.($host).config.system.build.diskoScript")
  bash -c $disko
  #
  # echo "Done formatting"
  #
  # generate_luks_key
  #
  # # echo "Copying SSH key pair"
  # mkdir /mnt/etc/ssh
  # # cp /tmp/id_ed25519 /mnt/etc/ssh/ssh_host_ed25519_key
  # # ssh-keygen -yf /mnt/etc/ssh/ssh_host_ed25519_key | save -f "/mnt/etc/ssh/ssh_host_ed25519_key"
  #
  # echo "Installing NixOS"
  # nixos-install --root /mnt --flake  --no-root-password
}
