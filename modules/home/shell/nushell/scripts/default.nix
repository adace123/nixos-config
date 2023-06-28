{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkIf config.modules.shell.nushell.enable {
    home.packages = [
      (pkgs.nuenv.mkScript {
        name = "systemd-toggle";
        script = builtins.readFile ./systemd-toggle.nu;
      })
    ];
  };
}
