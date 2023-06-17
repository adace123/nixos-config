use std

def connect [device: record<type: string name: string mac: string>] {
    try {
        std log info $"Connecting to ($device.name)"
        bluetoothctl connect $device.mac
      } catch {
          std log error $"Failed to connect to ($device.name)"
        }
}

def main [] {
  bluetoothctl devices Paired | lines | parse '{type} {mac} {name}' | each {|dev| connect $dev}
}
