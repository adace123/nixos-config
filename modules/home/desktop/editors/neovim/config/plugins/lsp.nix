_: {
  programs.nixvim = {
    plugins = {
      fidget.enable = true;
      lsp = {
        enable = true;
        preConfig = ''
          -- add additional capabilities supported by nvim-cmp
          -- nvim has not added foldingRange to default capabilities, users must add it manually
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
          }
        '';
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
          })
        '';
        servers = {
          bashls.enable = true;
          lua-ls.enable = true;
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
          ruff-lsp.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          terraformls.enable = true;
          tflint.enable = true;
          taplo.enable = true;
          tsserver.enable = true;
          zls.enable = true;
          gopls.enable = true;
          nushell.enable = true;
        };
        keymaps = {
          silent = true;
        };
      };
    };
    keymaps = [
      {
        key = "<leader>cR";
        action = ":LspRestart<CR>";
        options.desc = "LspRestart";
      }
    ];
    autoCmd = [
      {
        event = ["BufNewFile" "BufRead"];
        pattern = ["*.nu"];
        command = "set ft=nu";
      }
    ];
  };
}
