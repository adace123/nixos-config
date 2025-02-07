{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.emulators.ghostty;
  zellijLayout = config.adace.terminal.tools.zellij.defaultLayout;
in
with lib;
{
  options.adace.terminal.emulators.ghostty = {
    enable = mkEnableOption "ghostty";
    isDefaultTerminal = mkEnableOption "Set ghostty as default terminal emulator";
  };
  config = mkIf cfg.enable {
    home.sessionVariables.TERMINAL = mkIf cfg.isDefaultTerminal "ghostty";
    programs.ghostty = {
      enable = pkgs.stdenv.isLinux;
      settings = {
        theme = "catppuccin-mocha";
        clipboard-read = "allow";
        clipboard-write = "allow";
        window-padding-x = 10;
        window-padding-y = 10;
        background-opacity = 0.9;
        font-family = "JetBrainsMono Nerd Font Mono";
        command = "${pkgs.nushell}/bin/nu -c zellij --layout=${zellijLayout}";
        font-size = 15;
        keybind = [
          "ctrl+comma=reload_config"
          "ctrl+equal=increase_font_size:1"
          "ctrl+minus=decrease_font_size:1"
          "ctrl+enter=new_split:down"
          "ctrl+shift+enter=new_split:right"
          "global:alt+shift+enter=toggle_quick_terminal"
        ];
      };
    };
    # TODO: Deprecate this once nixpkgs version of ghostty can be built on Darwin
    xdg.configFile."ghostty/config".text = mkIf pkgs.stdenv.isDarwin ''
      clipboard-read = allow
      clipboard-write = allow
      window-padding-x = 10
      window-padding-y = 10
      background-opacity = 0.9
      command = ${pkgs.nushell}/bin/nu -c "zellij --layout=${zellijLayout}"
      theme = catppuccin-mocha

      font-family = JetBrainsMono Nerd Font Mono
      font-size = 15

      keybind = ctrl+comma=reload_config
      keybind = ctrl+equal=increase_font_size:1
      keybind = ctrl+minus=decrease_font_size:1
      keybind = ctrl+enter=new_split:down
      keybind = ctrl+shift+enter=new_split:right
      keybind = global:alt+shift+enter=toggle_quick_terminal
    '';
  };
}
