{
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.terminal.wezterm;
in
  with lib; {
    options.modules.desktop.terminal.wezterm.enable = mkEnableOption "wezterm";
    config = mkIf cfg.enable {
      programs.wezterm = {
        enable = true;
        extraConfig = ''
          return {
            font = wezterm.font("JetBrainsMono Nerd Font Mono"),
            font_size = 16,
            automatically_reload_config = true,
            window_close_confirmation = "NeverPrompt",
            color_scheme = "Catppuccin Macchiato",
            bold_brightens_ansi_colors = true,
            enable_wayland = true,
            front_end = "OpenGL",
            hide_tab_bar_if_only_one_tab = true,
          }
        '';
      };
    };
  }
