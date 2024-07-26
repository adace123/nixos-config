{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.terminal.kitty;
in
  with lib; {
    options.modules.desktop.terminal.kitty.enable = mkEnableOption "kitty";
    config = mkIf cfg.enable {
      programs.kitty = {
        enable = true;
        font = {
          name = "JetBrainsMono Nerd Font Mono";
          size = 16;
        };
        settings = {
          allow_remote_control = "yes";
          shell_integration = "enabled";
          listen_on = "unix:/tmp/mykitty";
          confirm_os_window_close = 0;
          cursor_blink_interval = 0;
          enabled_layouts = "fat, grid";
          shell = "${pkgs.nushell}/bin/nu";
          background_opacity = "0.94";
          resize_debounce_time = "0";
          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}:{title}";
          window_margin_width = 1;
          window_padding_width = 7;
          exe_search_path = "+/etc/profiles/per-user/${config.home.username}/bin";
          startup_session = mkIf pkgs.stdenv.isDarwin "~/.config/kitty/work.conf"; # Only enable session for work laptop
        };

        keybindings = {
          "ctrl+enter" = "launch --cwd=current";
          "ctrl+j" = "kitten pass_keys.py bottom ctrl+j";
          "ctrl+k" = "kitten pass_keys.py top    ctrl+k";
          "ctrl+h" = "kitten pass_keys.py left   ctrl+h";
          "ctrl+l" = "kitten pass_keys.py right  ctrl+l";
          "ctrl+]" = "next_tab";
          "ctrl+[" = "previous_tab";
          "alt+l" = "clear_terminal to_cursor active";
          "ctrl+shift+b" = "launch btop";
          "ctrl+shift+d" = "launch lazydocker";
          "ctrl+shift+k" = "launch k9s";
          "ctrl+shift+t" = "launch tgpt -i";
          "ctrl+shift+y" = "launch --cwd yazi";
        };

        extraConfig = ''
          # kitty-scrollback.nvim Kitten alias
          action_alias kitty_scrollback_nvim kitten ${pkgs.kittyScrollback}/python/kitty_scrollback_nvim.py
          # Browse scrollback buffer in nvim
          map kitty_mod+h kitty_scrollback_nvim
          # Browse output of the last shell command in nvim
          map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
        '';
      };
    };
  }
