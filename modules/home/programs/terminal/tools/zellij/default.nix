{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.desktop.terminal.zellij;
in
with lib;
{
  options.modules.desktop.terminal.zellij.enable = mkEnableOption "zellij";
  config = mkIf cfg.enable {
    programs.zellij.enable = true;
    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    home.file.".config/zellij/layouts/layout.kdl".source = ./layout.kdl;
  };
}
