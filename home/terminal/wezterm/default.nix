{
  lib,
  config,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./config.lua;
  };

  home.sessionVariables.TERMINAL = "wezterm";
}
