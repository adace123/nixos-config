use std

let-env config = {
  show_banner: false
}

def sc-list [] {
  # TODO: name + unit_type cols
  let system_services = (systemctl -o json | from json | insert type "system")
  let user_services = (systemctl -o json --user | from json | insert type "user")
  $system_services | append $user_services
}

def jt-debug [] {
  # TODO: Stream to a table
  journalctl -b -p warning -o json | lines | each {|| from json} | sort-by PRIORITY | select _TRANSPORT PRIORITY MESSAGE | where MESSAGE != null | less
}

def kget [] {
  # TODO
}
