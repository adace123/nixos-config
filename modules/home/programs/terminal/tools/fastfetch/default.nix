{
  config,
  lib,

  ...
}:
let
  cfg = config.adace.programs.terminal.tools.fastfetch;
in
with lib;
{
  options.adace.programs.terminal.tools.fastfetch.enable = mkEnableOption "fastfetch";
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
