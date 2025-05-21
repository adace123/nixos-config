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
      (python313.withPackages (
        p: with p; [
          black
          isort
          jupytext
          requests
          ipython
          polars
        ]
      ))
      pyright
      ruff
      uv
    ];

    home.file.".ipython/profile_default/ipython_config.py".source = ./ipython_config.py;
  };
}
