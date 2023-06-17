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
            font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" }),
            font_size = 18,
            enable_tab_bar = false,
            automatically_reload_config = true,
            window_close_confirmation = "NeverPrompt",
            color_scheme = "Catppuccin Macchiato",
            bold_brightens_ansi_colors = true,
          }
        '';
      };
    };
  }
