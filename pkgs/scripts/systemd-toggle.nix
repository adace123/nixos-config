{pkgs}:
pkgs.nuenv.mkScript {
  name = "systemd-toggle";
  script = ''
    def main [service: string] {
      let is_active = (systemctl is-active --all $service)
      if $is_active == "inactive" {
        sudo systemctl restart $service --all
      } else {
        sudo systemctl stop $service --all
      }
    }
  '';
}
