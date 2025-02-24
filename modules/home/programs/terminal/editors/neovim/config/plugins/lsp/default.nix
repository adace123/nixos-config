_: {
  programs.nixvim = {
    plugins = {
      fidget.enable = true;
      lsp = {
        enable = true;
        postConfig = ''
          vim.diagnostic.config({
            update_in_insert = true,
            underline = true,
            signs = {
              severity = { min = vim.diagnostic.severity.WARN },
            },
            virtual_text = {
              severity = { min = vim.diagnostic.severity.WARN }
            },
            float = {
              border = "rounded"
            }
          })
        '';
        servers = {
          bashls.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
          jsonls.enable = true;
          yamlls = {
            enable = true;
            extraOptions.capabilities.textDocument.foldingRange = {
              dynamicRegistration = false;
              lineFoldingOnly = true;
            };
          };
          nixd.enable = true;
          ruff.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          terraformls.enable = true;
          tflint.enable = true;
          taplo.enable = true;
          ts_ls.enable = true;
          # zls.enable = true;
          gopls.enable = true;
          nushell.enable = true;
        };
        keymaps = {
          silent = true;
        };
      };
    };
    opts.inccommand = "split";
    keymaps = [
      {
        key = "<leader>cR";
        action = ":LspRestart<CR>";
        options.desc = "LspRestart";
      }
      {
        key = "<leader>cf";
        action.__raw = "function() vim.lsp.buf.format() end";
        options.desc = "Format";
      }
      {
        key = "<leader>cd";
        action.__raw = "vim.diagnostic.open_float";
        options.desc = "Show diagnostic";
      }
      {
        key = "<leader>cr";
        action = ":IncRename ";
        options.desc = "Rename";
      }
      {
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "LSP Docs";
      }
    ];
    autoCmd = [
      {
        event = [
          "BufNewFile"
          "BufRead"
        ];
        pattern = [ "*.nu" ];
        command = "set ft=nu";
      }
    ];
  };
}
