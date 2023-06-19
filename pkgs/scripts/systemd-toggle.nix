{
  pkgs,
  inputs,
  ...
}:
pkgs.nuenv.mkScript {
  name = "systemd-toggle";
  script = ''
    use std
    def main [service: string --user: bool] {
      let flag = if $user { "--user" } else { "" }
      let is_active = (systemctl $flag is-active $service)

      if $is_active == "inactive" {
        std log info $"Restarting service $service"
        systemctl $flag restart $service
      } else {
        std log info $"Stopping service $service"
        systemctl $flag stop $service
      }
    }
  '';
}
