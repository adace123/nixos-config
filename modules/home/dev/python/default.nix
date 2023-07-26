{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.python;
  nvim_cfg = config.modules.editors.neovim;
in
  with lib; {
    options.modules.dev.python.enable = mkEnableOption "Python development tools";

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        poetry
        (python311.withPackages (p:
          with p; [
            requests
            ptpython
            jupyterlab # TODO: use jupyenv
            pytest
          ]))
      ];

      home.file.".config/ptpython/config.py".source = ./ptpython.py;

      modules.editors.neovim.languageSupport = mkIf nvim_cfg.enable [
        {
          name = "pyright";
          package = pkgs.pyright;
          type = "lsp";
        }
        {
          name = "ruff_lsp";
          package = pkgs.python311Packages.ruff-lsp;
          type = "lsp";
        }
        {
          name = "ruff";
          package = pkgs.ruff;
          type = "formatting";
        }
        {
          name = "black";
          package = pkgs.python311Packages.black;
          type = "formatting";
        }
        {
          name = "ruff";
          package = pkgs.ruff;
          type = "diagnostics";
        }
      ];

      programs.neovim = mkIf nvim_cfg.enable {
        extraPackages = [
          pkgs.mypy
        ];

        plugins = [(pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [p.python]))];
      };
    };
  }
