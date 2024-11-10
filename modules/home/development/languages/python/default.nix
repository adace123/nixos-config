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
      (python312.withPackages (
        p: with p; [
          black
          isort
          jupytext
          ptpython
          requests
        ]
      ))
      pyright
      ruff
      ruff-lsp
      uv
    ];

    home.file.".config/ptpython/config.py".source = ./ptpython.py;
  };
}
