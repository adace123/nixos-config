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
        options = with config.colorScheme.palette; {
          font = "JetBrainsMono Nerd Font";
          default-bg = "#${base00}";
          default-fg = "#${base05}";

          statusbar-bg = "#${base01}";
          statusbar-fg = "#${base05}";

          inputbar-bg = "#${base01}";
          inputbar-fg = "#${base05}";

          notification-bg = "#${base00}";
          notification-fg = "#${base05}";

          notification-error-bg = "#${base00}";
          notification-error-fg = "#${base08}";

          notification-warning-bg = "#${base09}";
          notification-warning-fg = "#${base09}";

          highlight-color = "#${base0A}";
          highlight-active-color = "#${base0D}";

          completion-bg = "#${base01}";
          completion-fg = "#${base0D}";

          completion-highlight-bg = "#${base05}";
          completion-highlight-fg = "#${base00}";

          recolor-lightcolor = "#${base00}";
          recolor-darkcolor = "#${base05}";

          index-active-bg = "#${base00}";
          index-active-fg = "#${base05}";

          render-loading-bg = "#${base00}";
          render-loading-fg = "#${base05}";

          recolor = true;
          recolor-keephue = true;
        };
        extraConfig = ''
          map = zoom in
          map + zoom
        '';
      };
    };
  }
