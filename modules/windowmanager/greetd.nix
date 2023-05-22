{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.window-manager;
  wm = lib.getExe config.programs.${cfg.name}.package;
in
  with lib; {
    config = mkIf cfg.enable {
      services.greetd = {
        enable = true;
        settings = {
          default_session.command = "${lib.getExe pkgs.greetd.tuigreet} --time --cmd ${wm}";
        };
      };

      environment.systemPackages = with pkgs; [
        (catppuccin-gtk.override {
          accents = ["mauve"];
          size = "compact";
          variant = "mocha";
        })
        bibata-cursors
        papirus-icon-theme
      ];
    };
  }
