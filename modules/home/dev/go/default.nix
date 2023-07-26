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
      home.packages = [pkgs.go];

      modules.editors.neovim.languageSupport = mkIf nvim_cfg.enable [
        {
          name = "gopls";
          package = pkgs.gopls;
          type = "lsp";
        }
        {
          name = "gofmt";
          package = pkgs.gotools;
          type = "formatting";
        }
        {
          name = "goimports";
          package = pkgs.gotools;
          type = "formatting";
        }
      ];

      programs.neovim = mkIf nvim_cfg.enable {
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.go]))];
      };
    };
  }
