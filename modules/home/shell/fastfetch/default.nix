{
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.fastfetch;
in
  with lib; {
    options.modules.shell.fastfetch.enable = mkEnableOption "fastfetch";
    config = mkIf cfg.enable {
      programs.fastfetch = {
        enable = true;
        settings = {
          modules = [
            "title"
            "separator"
            "os"
            "host"
            "kernel"
            "uptime"
            "shell"
            "de"
            "wm"
            "wmtheme"
            "theme"
            "icons"
            "font"
            "terminal"
            "terminalfont"
            "cpu"
            "gpu"
            "memory"
            "swap"
            "disk"
            "localip"
            "break"
          ];
        };
      };
    };
  }
