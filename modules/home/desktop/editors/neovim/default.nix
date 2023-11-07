{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.neovim;
in
  with lib; {
    imports = [./config ./plugins];

    options.modules.editors.neovim.enable = mkEnableOption "neovim";

    config = mkIf cfg.enable {
      home.sessionVariables.EDITOR = "nvim";
      programs.nushell.extraConfig = ''$env.EDITOR = "nvim"'';

      programs.nixvim = {
        enable = true;
        clipboard.providers = {
          wl-copy.enable = true;
          xclip.enable = true;
        };
      };

      home.packages = with pkgs; [
        zig # Treesitter compiler
        tree-sitter
        nodejs

        # language-servers
        nixd
        lua-language-server
        rust-analyzer
        pyright
        ruff
        ruff-lsp

        # formatters
        alejandra
        stylua
        yamlfmt
      ];
    };
  }
