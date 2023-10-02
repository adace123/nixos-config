{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.go;
  nvim_cfg = config.modules.editors.neovim;
in
  with lib; {
    options.modules.dev.go.enable = mkEnableOption "go";
    config = mkIf cfg.enable {
      home.packages = [pkgs.go pkgs.gotools];

      modules.editors.neovim.languageSupport = mkIf nvim_cfg.enable [
        {
          name = "gopls";
          command = "${pkgs.gopls}/bin/gopls";
          type = "lsp";
        }
        {
          name = "gofmt";
          command = "${pkgs.go}/bin/go";
          cmdArgs = ["fmt"];
          type = "formatting";
        }
        {
          name = "goimports";
          command = "${pkgs.gotools}/bin/goimports";
          cmdArgs = ["--srcdir" "$DIRNAME"];
          type = "formatting";
        }
      ];

      programs.neovim = mkIf nvim_cfg.enable {
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.go]))];
      };
    };
  }
