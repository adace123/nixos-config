let-env config = {
  show_banner: false
}

def sc-list [] {
  systemctl -o json | from json
}

def dmesg-err [] {
  sudo dmesg -J --level=warn+ | from json | get dmesg | sort-by pri
}

def kget [] {
  # TODO
}
