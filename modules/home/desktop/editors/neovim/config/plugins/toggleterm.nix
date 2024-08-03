{
  programs.nixvim = {
    plugins = {
      toggleterm = {
        enable = true;
        settings = {
          insertMappings = true;
          direction = "horizontal";
          autoScroll = true;
          closeOnExit = true;
        };
      };
      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>t";
          desc = "terminal+";
        }
      ];
    };
    extraConfigLua = ''
      function _G.set_terminal_keymaps()
      	local opts = { buffer = 0 }
      	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
    '';
    keymaps = [
      {
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<CR>";
        options.desc = "Horizontal terminal";
      }
      {
        key = "<leader>tf";
        action = "<cmd>ToggleTerm direction=float<CR>";
        options.desc = "Floating terminal";
      }
    ];
  };
}
