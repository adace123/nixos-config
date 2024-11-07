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
  options.adace.terminal.emulators.wezterm.enable = mkEnableOption "wezterm";
  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./config.lua;
    };
  };
}
