{
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.pdf;
in
  with lib; {
    options.modules.desktop.pdf.enable = mkEnableOption "zathura";
    config = mkIf cfg.enable {
      xdg.mimeApps = {
        defaultApplications."application/pdf" = ["org.pwmt.zathura.desktop"];
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
