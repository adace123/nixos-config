{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.neovim;
  lsp-servers = builtins.concatStringsSep ", " (map (x: "\n \"${x}\"") cfg.lsp-servers);
  null-ls-builder = type: list: (builtins.map (x: "\n\t\tnull_ls.builtins.${type}.${x}") list);
  null-ls-settings = builtins.concatStringsSep ", " (
    (null-ls-builder "formatting" cfg.formatters)
    ++ (null-ls-builder "diagnostics" cfg.diagnostics)
  );
in
  with lib;
  {
    options.modules.editors.neovim = with types; {
      enable = mkEnableOption "neovim";
      # lsp-packages = mkOption {
      #   description = "Attr set of Null-LS/LSP server names and corresponding package names";
      #   type = types.attrsOf (submodule);
      # };
      lsp-servers = mkOption {
        description = "List of LSP servers to be managed by Mason";
        type = listOf str;
        default = [];
      };
      tsLanguages = mkOption {
        description = "Treesitter language sources";
        type = listOf str;
        default = [];
      };
      formatters = mkOption {
        description = "Null-LS formatters";
        type = listOf str;
        default = [];
      };
      diagnostics = mkOption {
        description = "Null-LS diagnostics";
        type = listOf str;
        default = [];
      };
      code-actions = mkOption {
        description = "Null-LS code actions";
        type = listOf str;
        default = [];
      };
    };

    config = mkIf cfg.enable {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        # base list of LSPs and formatters
        extraPackages = with pkgs; [
          # nix
          alejandra
          statix
          # nixd TODO: re-enable once this is more stable

          # lua
          stylua
          selene
          lua-language-server

          # yaml
          yaml-language-server
          yamllint
          yamlfmt

          # json
          (pkgs.writeScriptBin "vscode-json-language-server" ''
            #!/usr/bin/env bash
            exec ${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver $@
          '')

          # toml
          taplo-lsp
        ];
      };

      home.file.".config/nvim".source = inputs.astronvim;

      home.file.".config/astronvim/lua/user" = {
        source = ./config;
        recursive = true;
      };

      home.file.".config/astronvim/lua/user/lsp/servers.lua".text = mkIf (cfg.lsp-servers != []) ''
        return {
          ${lsp-servers}
        }
      '';

      home.file.".config/astronvim/lua/user/plugins/null-ls.lua".text = mkIf (cfg.formatters != []) ''
        return {
          "jose-elias-alvarez/null-ls.nvim",
          opts = function(_, config)
            local null_ls = require("null-ls")
            config.sources = {
              ${null-ls-settings}
            }
            return config
          end
        }
      '';

      modules.editors.neovim = {
        lsp-servers = [
          "lua_ls"
          # "nixd" TODO: re-enable once this is more stable
          "statix"
          "jsonls"
          "taplo"
        ];

        formatters = [
          "stylua"
          "yamlfmt"
          "alejandra"
        ];

        diagnostics = [
          "yamllint"
        ];
      };

      home.packages = with pkgs; [
        zig # Treesitter compiler
        tree-sitter
        nodejs
      ];
    };
  }
