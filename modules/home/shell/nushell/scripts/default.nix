{pkgs, ...}: {
  pkgs.systemd-toggle = pkgs.nuenv.mkScript {
    name = "systemd-toggle";
    script = builtins.readFile ./systemd-toggle.nu;
  };
}
