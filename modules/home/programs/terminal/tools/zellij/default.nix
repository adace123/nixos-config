{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.terminal.tools.zellij;
in
with lib;
{
  options.adace.terminal.tools.zellij.enable = mkEnableOption "zellij";
  config = mkIf cfg.enable {
    programs.zellij.enable = true;
    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    home.file.".config/zellij/layouts/layout.kdl".source = ./layout.kdl;
  };
}
