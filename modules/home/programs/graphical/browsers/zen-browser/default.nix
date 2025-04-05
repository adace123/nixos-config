{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.browsers.zen;
in
with lib;
{
  options.adace.desktop.browsers.zen = {
    enable = mkEnableOption "Zen Browser";
    isDefaultBrowser = mkEnableOption "Set Zen Browser as default browser";
  };

  config = mkIf cfg.enable {
    home.sessionVariables.BROWSER = mkIf cfg.isDefaultBrowser "zen";

    home.packages = [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];
  };
}
