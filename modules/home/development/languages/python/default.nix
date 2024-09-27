{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.languages.python;
in
with lib;
{
  options.adace.development.languages.python.enable = mkEnableOption "Enable Python dev tools";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bandit
      (python312.withPackages (
        p: with p; [
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
        ]
      ))
      poetry
      pyright
      pyenv
      ruff
      ruff-lsp
      uv
    ];

    home.file.".config/ptpython/config.py".source = ./ptpython.py;
  };
}
