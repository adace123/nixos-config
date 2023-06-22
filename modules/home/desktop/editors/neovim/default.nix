{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.editors.neovim;
in
  with lib; {
    options.modules.desktop.editors.neovim.enable = mkEnableOption "neovim";
    config = mkIf cfg.enable {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

      home.file.".config/nvim".source = inputs.astronvim;
      home.file.".config/astronvim/lua/user".source = ./config;

      home.packages = with pkgs; [
        tree-sitter
        mypy
      ];
    };
  }
