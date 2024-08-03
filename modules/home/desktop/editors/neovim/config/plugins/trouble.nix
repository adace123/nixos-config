{
  programs.nixvim = {
    plugins = {
      trouble.enable = true;
      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>x";
          desc = "diagnostics+";
        }
      ];
    };
    keymaps = [
      {
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle focus=true<CR>";
        options.desc = "Diagnostics";
      }
      {
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>";
        options.desc = "Buffer diagnostics";
      }
      {
        key = "<leader>xe";
        action = "<cmd>Touble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<CR>";
        options.desc = "Errors";
      }
      {
        key = "gr";
        action = "<cmd>Trouble lsp_references toggle focus=true<CR>";
        options.desc = "LSP references";
      }
      {
        key = "gd";
        action = "<cmd>Trouble lsp_definitions<CR>";
        options.desc = "Goto definition";
      }
      {
        key = "]d";
        action = "<cmd>Trouble diagnostics next jump=true<CR>";
        options.desc = "Next diagnostic";
      }
      {
        key = "[d";
        action = "<cmd>Trouble diagnostics prev jump=true<CR>";
        options.desc = "Prev diagnostic";
      }
      {
        key = "<leader>cf";
        action.__raw = "function() vim.lsp.buf.format() end";
        options.desc = "Format";
      }
    ];
  };
}
