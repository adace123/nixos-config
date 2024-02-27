def sc-list [] {
  # TODO: name + unit_type cols
  let system_services = (systemctl -o json | from json | insert type "system")
  let user_services = (systemctl -o json --user | from json | insert type "user")
  $system_services | append $user_services
}

def jt [] {
  journalctl -xe | tspin
}

def jtf [service: string] {
  journalctl -flu $service | tspin
}

def dmesg [] {
  sudo dmesg | tspin
}

def jt-debug [] {
  # TODO: Stream to a table
  journalctl -b -p warning -o json | lines | each {|| from json} | sort-by PRIORITY | select _TRANSPORT PRIORITY MESSAGE | where MESSAGE != null
}

def hyprlogs [] {
  cat $"/tmp/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/hyprland.log" | tspin -f
}

def nix-diff [] {
  nixos-rebuild build --flake $"($env.DOTFILES_DIR)#(hostname)"
  nvd diff /run/current-system $"($env.DOTFILES_DIR)/result"
}

def rf [pattern: string] {
  # open ripgrep file matches in editor
  let result = rg -l $pattern | fzf -m | lines
  $result | str join " " | xargs $env.EDITOR
}

def nxs [pkg: string] {
  nix shell nixpkgs#($pkg)
}

def zja [] {
    let sessions = zellij ls -s | lines
    if (($sessions | length) == 0) {
      echo "No sessions found"
      let session_name = gum input --placeholder "Name of new session"
      if ($session_name == "") {
        zellij
      } else {
        zellij attach -c $session_name
      }
    } else {
        mut selected_session = $sessions | first
        if (($sessions | length) > 1) {
          $selected_session = (gum filter --header "Attach to a Zellij session" ...($sessions))
        }
        zellij attach $selected_session
  }
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

module sys {
  export def "sys usb" [] {
    ^lsusb | lines | parse "Bus {busId} Device {deviceId}: ID {id} {name}"
  }

  export def "sys pci" [] {
    ^lspci -v -mm | parse --regex "Slot:(?<slot>.+)\nClass:(?<class>.+)\nVendor:(?<vendor>.+)\n(?<device>.+)\nSVendor:(?<svendor>.+)\nSDevice:(?<sdevice>.+)\nRev:(?<rev>.+)\nProgIf:(?<progif>.+)"
  }

  export def "sys disk" [] {
    ^lsblk -l --json | from json | get blockdevices | flatten
  }

  export def "sys disk-health" [disk: string] {
    sudo smartctl $disk --attributes | str trim | detect columns --skip 6
  }

  export def "sys vuln" [] {
    ls /sys/devices/system/cpu/vulnerabilities
    | each {|it|
      {
        name: ($it.name | path basename),
        migitation: (open $it.name | str trim)
      }
    }
  }

  export def "sys users" [] {
    open -r /etc/passwd
    | from csv -s ':' --noheaders
    | reject password
    | rename username password userid groupid comment home shell
  }

  export def "sys os" [] {
   open -r /etc/os-release
    | from csv -s "=" --noheaders
    | rename key value
  }

  export def "sys bpf" [] {
    sudo bpftool prog show -j | from json
  }
}

module ssh {
  export def "ssh keys ls" [--short (-s)] {
    ls ~/.ssh
    | where name =~ ".*.pub$"
    | each {|it|
      let name = ($it.name | path parse | get stem)
      open $it.name
      | parse "{method} {pubkey} {comment}"
      | merge ([$name] | wrap name)
      | update comment {|it| $it.comment | str trim}
    }
    | flatten
    | select name method comment pubkey
    | if ($short) {
      update pubkey {|it|
        let end = ($it.pubkey | split chars | last 10 | str join)
        $"...($end)"
      }
    } else { $in }
  }
}
