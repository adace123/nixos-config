{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.suites.terminal;
in
with lib;
{
  options.adace.suites.terminal.enable = mkEnableOption "Terminal tools";
  config = mkIf cfg.enable {
    adace.terminal = {
      emulators = {
        kitty.enable = true;
        wezterm.enable = true;
        ghostty = {
          enable = true;
          isDefaultTerminal = true;
        };
      };
      shells.nushell.enable = true;
      tools = {
        btop.enable = true;
        direnv.enable = true;
        fastfetch.enable = true;
        lazygit.enable = true;
        modern-unix.enable = true;
        ssh.enable = true;
        starship.enable = true;
        tgpt.enable = true;
        yazi.enable = true;
        zathura.enable = true;
        zellij.enable = true;
      };
    };
  };
}
