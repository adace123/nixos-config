{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.browsers.firefox;
in
  with lib; {
    options.modules.desktop.browsers.firefox.enable = mkEnableOpt "Firefox browser";
    config = mkIf cfg.enable {
      home.sessionVariables.BROWSER = "firefox";
      programs.firefox = {
        enable = true;
        package =
          if config.mmodules.desktop.hyprland.enable
          then pkgs.firefox-wayland
          else pkgs.firefox;
        profiles.default = {
            extensions = with pkgs.nur.rycee.firefox-extensions; [
              ublock-origin
              tridactyl
              darkreader
            ];
          };
      };
    };
  }
