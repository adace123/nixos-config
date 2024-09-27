{
  config,
  lib,
  pkgs,
  std,
  ...
}:
let
  cfg = config.modules.desktop.hyprland.addons;
  inherit (config.home.sessionVariables) TERMINAL;
in
with lib;
{
  config = mkIf cfg.enable {
    home.packages = [ pkgs.pyprland ];
    xdg.configFile.pypr = {
      target = "hypr/pyprland.toml";
      onChange = "${pkgs.pyprland}/bin/pypr reload";
      text = std.serde.toTOML {
        pyprland.plugins = [ "scratchpads" ];
        scratchpads = {
          terminal = {
            command = "${TERMINAL} --class=scratchpad";
            animation = "fromTop";
            unfocus = "hide";
          };
          btop = {
            command = "${TERMINAL} --class=scratchpad -e btop";
            animation = "fromTop";
            unfocus = "hide";
          };
          k9s = {
            command = "${TERMINAL} --class=scratchpad -e k9s";
            animation = "fromTop";
            unfocus = "hide";
          };
          tgpt = {
            command = "${TERMINAL} --class=scratchpad -e tgpt -i";
            animation = "fromTop";
            unfocus = "hide";
          };
          yazi = {
            command = "${TERMINAL} --class=scratchpad -e yazi ~";
            animation = "fromTop";
            unfocus = "hide";
          };
          wallpaper-picker = {
            command = "${TERMINAL} --class=scratchpad -e wallpaper-picker";
            animation = "fromTop";
            unfocus = "hide";
          };
        };
      };
    };
  };
}
