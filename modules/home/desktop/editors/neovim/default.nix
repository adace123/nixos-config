{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.neovim;
in
  with lib; {
    imports = [./language-support.nix];

    options.modules.editors.neovim.enable = mkEnableOption "neovim";

    config = mkIf cfg.enable {
      home.sessionVariables.EDITOR = "nvim";
      programs.nushell.extraConfig = ''$env.EDITOR = "nvim"'';
      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      home.file.".config/nvim".source = inputs.astronvim;

      home.file.".config/astronvim/lua/user" = {
        source = ./config;
        recursive = true;
      };

      home.packages = with pkgs; [
        zig # Treesitter compiler
        tree-sitter
        nodejs
      ];
    };
  }
