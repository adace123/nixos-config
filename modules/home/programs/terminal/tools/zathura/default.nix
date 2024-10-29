{
  config,
  lib,

  ...
}:
let
  cfg = config.adace.terminal.tools.zathura;
in
with lib;
{
  options.adace.terminal.tools.zathura.enable = mkEnableOption "zathura";
  config = mkIf cfg.enable {
    xdg.mimeApps = {
      defaultApplications."application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };

    programs.zathura = {
      enable = true;
      options = {
        font = "JetBrainsMono Nerd Font";
      };
      extraConfig = ''
        map = zoom in
        map + zoom
      '';
    };
  };
}
