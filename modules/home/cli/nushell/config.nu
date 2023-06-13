let-env config = {
  show_banner: false
}

def sc-list [] {
  systemctl -o json | from json
}
