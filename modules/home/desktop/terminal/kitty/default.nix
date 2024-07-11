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
          enabled_layouts = "splits,tall,fat,vertical,horizontal";
          shell = "${pkgs.nushell}/bin/nu";
          background_opacity = "0.90";
          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          tab_title_template = "{title.split('/')[-1]} {' :{}:'.format(num_windows) if num_windows > 1 else ''}";
          window_margin_width = 7;
        };
      };
    };
  }
