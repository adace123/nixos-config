{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.emulators.ghostty;
in
with lib;
{
  options.adace.terminal.emulators.ghostty = {
    enable = mkEnableOption "ghostty";
    isDefaultTerminal = mkEnableOption "Set ghostty as default terminal emulator";
  };
  config = mkIf cfg.enable {
    home.sessionVariables.TERMINAL = mkIf cfg.isDefaultTerminal "ghostty";
    xdg.configFile."ghostty/config".text = ''
      clipboard-read = allow
      clipboard-write = allow
      window-padding-x = 10
      window-padding-y = 10
      background-opacity = 0.9
      command = ${pkgs.nushell}/bin/nu
      theme = catppuccin-mocha

      font-family = JetBrainsMono Nerd Font Mono
      font-size = 15

      keybind = ctrl+comma=reload_config
      keybind = ctrl+equal=increase_font_size:1
      keybind = ctrl+minus=decrease_font_size:1
      keybind = ctrl+enter=new_split:down
      keybind = ctrl+shift+enter=new_split:right
      keybind = alt+shift+enter=toggle_quick_terminal

      keybind = unconsumed:ctrl+k=goto_split:top
      keybind = unconsumed:ctrl+j=goto_split:bottom
      keybind = unconsumed:ctrl+h=goto_split:left
      keybind = unconsumed:ctrl+l=goto_split:right

      keybind = ctrl+shift+l=clear_screen
    '';
  };
}
