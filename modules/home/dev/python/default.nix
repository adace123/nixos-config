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
        poetry
        (python311.withPackages (p:
          with p; [
            requests
            ptpython
            jupyterlab # TODO: use jupyenv
            # polars
            plotly
            pytest
          ]))
        ruff
        ruff-lsp
        pyright
      ];

      home.file.".config/ptpython/config.py".source = ./ptpython.py;
    };
  }
