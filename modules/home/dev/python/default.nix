{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.python;
in
  with lib; {
    options.modules.dev.python.enable = mkEnableOption "Python development tools";

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        bandit
        (python312.withPackages (p:
          with p; [
            black
            isort
            jupyterlab # TODO: use jupyenv
            jupytext
            marimo
            plotly
            ptpython
            pytest
            requests
            virtualenv
          ]))
        poetry
        pyright
        pyenv
        ruff
        ruff-lsp
      ];

      home.file.".config/ptpython/config.py".source = ./ptpython.py;
    };
  }
