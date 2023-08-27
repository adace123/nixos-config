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
            polars
            plotly
            pytest
          ]))
      ];

      home.file.".config/ptpython/config.py".source = ./ptpython.py;

      modules.editors.neovim.languageSupport = mkIf nvim_cfg.enable [
        {
          name = "pyright";
          command = "${pkgs.nodePackages.pyright}/bin/pyright-langserver";
          cmdArgs = ["--stdio"];
          type = "lsp";
        }
        {
          name = "ruff";
          command = "${pkgs.ruff}/bin/ruff";
          cmdArgs = ["--fix" "-n" "-e" "--stdin-filename" "$FILENAME" "-"];
          type = "formatting";
        }
        {
          name = "black";
          command = "${pkgs.black}/bin/black";
          cmdArgs = ["--stdin-filename" "$FILENAME" "--quiet" "-"];
          type = "formatting";
        }
        {
          name = "ruff";
          command = "${pkgs.ruff}/bin/ruff";
          cmdArgs = ["-n" "-e" "--stdin-filename" "$FILENAME" "-"];
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
