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

      modules.editors.neovim = mkIf nvim_cfg.enable {
        lsp-servers = ["pyright" "ruff_lsp"];
        formatters = ["ruff" "black"];
        diagnostics = ["ruff"];
      };

      programs.neovim = mkIf nvim_cfg.enable {
        extraPackages = with pkgs; [
          pyright
          mypy
          ruff
          (python311.withPackages (p: [p.ruff-lsp p.black]))
        ];

        plugins = [(pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [p.python]))];
      };
    };
  }
