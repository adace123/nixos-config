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

def rebuild [] {
  sudo nixos-rebuild switch --flake $"($env.DOTFILES_DIR)#(hostname)"
}

module jc-functions {
  export def bt-table [] {
    bluetoothctl devices | jc --bluetoothctl | from json
  }

  export def dig-table [...domains] {
    dig $domains | jc --dig | from json | get answer | flatten
  }

  export def git-log [] {
    git log | jc --git-log | from json | sort-by epoch | reverse
  }

  export def mounts [] {
    mount | jc --mount | from json
  }

  export def sysctl-table [] {
    sysctl -a | jc --sysctl | from json | transpose | rename setting value
  }
}

