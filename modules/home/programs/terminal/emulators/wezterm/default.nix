{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.emulators.wezterm;
in
with lib;
{
  options.adace.programs.terminal.emulators.wezterm.enable = mkEnableOption "wezterm";
  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        return {
          font = wezterm.font("JetBrainsMono Nerd Font Mono"),
          font_size = 16,
          default_prog = {"${pkgs.nushell}/bin/nu"},
          automatically_reload_config = true,
          window_close_confirmation = "NeverPrompt",
          color_scheme = "Catppuccin Macchiato",
          bold_brightens_ansi_colors = true,
          enable_wayland = false,
          hide_tab_bar_if_only_one_tab = true,
        }
      '';
    };
  };
}
