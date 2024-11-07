{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.terminal.emulators.wezterm;
in
with lib;
{
  options.adace.terminal.emulators.wezterm = {
    enable = mkEnableOption "wezterm";
    isDefaultTerminal = mkEnableOption "Set wezterm as default terminal emulator";
  };
  config = mkIf cfg.enable {
    home.sessionVariables.TERMINAL = mkIf cfg.isDefaultTerminal "wezterm";
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./config.lua;
    };
  };
}
