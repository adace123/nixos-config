{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.graphical.window-managers.hyprland.addons.waybar;
  inherit (config.home.sessionVariables) TERMINAL;
in
with lib;
{
  options.adace.programs.graphical.window-managers.hyprland.addons.pyprland.enable = mkEnableOption "pyprland";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.pyprland ];
    xdg.configFile.pypr = {
      target = "hypr/pyprland.toml";
      onChange = "${pkgs.pyprland}/bin/pypr reload";
      text = lib.std.serde.toTOML {
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
