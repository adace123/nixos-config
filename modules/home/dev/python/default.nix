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
        (python311.withPackages (p:
          with p; [
            requests
            ipython
          ]))
        ruff
        black
        isort
      ];

      programs.neovim.extraPackages = mkIf nvim_cfg.enable (with pkgs; [
        nodePackages.pyright
      ]);
    };
  }
