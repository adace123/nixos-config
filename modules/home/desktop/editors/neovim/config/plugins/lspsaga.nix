{
  programs.nixvim = {
    plugins = {
      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>c";
          desc = "code+";
        }
      ];
      lspsaga = {
        enable = true;
        lightbulb.sign = false;
        scrollPreview = {
          scrollDown = "<C-j>";
          scrollUp = "<C-k>";
        };
        finder.keys.toggleOrOpen = "<CR>";
      };
    };
    keymaps = [
      {
        key = "gr";
        action = "<cmd>Lspsaga finder<CR>";
        options.desc = "Lsp finder";
      }
      {
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options.desc = "Code action";
      }
      {
        key = "<leader>cr";
        action = "<cmd>Lspsaga rename ++project<CR>";
        options.desc = "Rename word in project";
      }
      {
        key = "<leader>cf";
        action.__raw = "function() vim.lsp.buf.format() end";
        options.desc = "Format";
      }
      {
        key = "gD";
        action = "<cmd>Lspsaga peek_definition<CR>";
        options.desc = "Peek definition";
      }
      {
        key = "gd";
        action = "<cmd>Lspsaga goto_definition<CR>";
        options.desc = "Goto definition";
      }
      {
        key = "<leader>cd";
        action = "<cmd>Lspsaga show_line_diagnostics<CR>";
        options.desc = "Line diagnostics";
      }
      {
        key = "<leader>cD";
        action = "<cmd>Lspsaga show_buf_diagnostics<CR>";
        options.desc = "Buffer diagnostics";
      }
      {
        key = "[d";
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        options.desc = "Previous diagnostic";
      }
      {
        key = "]d";
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        options.desc = "Next diagnostic";
      }
      {
        key = "K";
        action = "<cmd>Lspsaga hover_doc ++keep<CR>";
        options.desc = "Hover doc";
      }
      {
        key = "<leader>cO";
        action = "<cmd>Lspsaga outline<CR>";
        options.desc = "Toggle outline";
      }
    ];
  };
}
