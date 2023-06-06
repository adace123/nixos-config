def main [] {
  let password = (input -s "LUKS password: ")
  let password2 = (input -s "\nConfirm LUKS password: ")
  if $password != $password2 {
    echo "\nError: Passwords don't match"
    exit 1
  }
  $password | save "/tmp/cryptroot.key"

  echo "Generating LUKS key file"
  dd bs=4096 count=1 iflag=fullblock if=/dev/random of="keyfile.bin"
  chmod 000 keyfile.bin
  cryptsetup luksAddKey /dev/disk/by-partlabel/primary --key-file=/tmp/cryptroot.key keyfile.bin
  mkdir /mnt/boot/initrd
  mv keyfile.bin /mnt/boot/initrd/keyfile.bin
}
