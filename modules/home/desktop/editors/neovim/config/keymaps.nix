{
  programs.nixvim = {
    keymaps = [
      {
        key = "kj";
        action = "<Esc>";
        options.desc = "Escape";
        mode = ["i"];
      }
      {
        key = "jk";
        action = "<Esc>";
        options.desc = "Escape";
        mode = ["i"];
      }
      {
        key = "jj";
        action = "<Esc>";
        options.desc = "Escape";
        mode = ["i"];
      }
      {
        key = "U";
        action = "<C-r>";
        options.desc = "Undo";
      }
      {
        key = "<C-z>";
        action = "<Esc>ui";
        options.desc = "Undo in Insert Mode";
        mode = ["i"];
      }
      {
        key = "<C-x>";
        action = "<C-w>q";
        options.desc = "Close window";
      }
      {
        key = "<leader>/";
        action = ''
          function()
            require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
          end
        '';
        lua = true;
        options.desc = "Toggle comment line";
      }
      {
        key = "<leader>/";
        action = ''
          <esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())
        '';
        options.desc = "Toggle comment for selection";
        mode = ["v"];
      }
      {
        key = "<C-s>";
        action = ":w<CR>";
        options.desc = "Save";
      }
      {
        action = "'_dP";
        key = "<leader>p";
        options = {
          desc = "Paste without updating buffer";
        };
        mode = [
          "v"
        ];
      }
      {
        action = ">gv";
        key = ">";
        options.desc = "Stay in visual mode during outdent";
        mode = [
          "v"
          "x"
        ];
      }
      {
        action = "<gv";
        key = "<";
        options.desc = "Stay in visual mode during indent";
        mode = [
          "v"
          "x"
        ];
      }
      {
        key = "r";
        action = "y:%s/<C-r>0/";
        options.desc = "Replace word under cursor";
        mode = ["v"];
      }
      {
        key = "<C-h>";
        action = "<C-w>g";
        options.desc = "Navigate left";
      }
      {
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Navigate left";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Navigate right";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Navigate down";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Navigate up";
      }
      {
        key = "<C-Up>";
        action = ":resize -2<CR>";
        options.desc = "Resize up";
      }
      {
        key = "<C-Down>";
        action = ":resize +2<CR>";
        options.desc = "Resize down";
      }
      {
        key = "<C-Left>";
        action = ":vertical resize -2<CR>";
        options.desc = "Resize left";
      }
      {
        key = "<C-Up>";
        action = ":vertical resize +2<CR>";
        options.desc = "Resize right";
      }
      {
        key = "<leader>sv";
        action = "<C-w>v";
        options.desc = "Vertical split";
      }
      {
        key = "<leader>sh";
        action = "<C-w>s";
        options.desc = "Horizontal split";
      }
      {
        key = "<leader><tab>n";
        action = "<cmd>tabnew<CR>";
        options.desc = "New tab";
      }
      {
        key = "<leader><tab>x";
        action = "<cmd>tabclose<CR>";
        options.desc = "Close tab";
      }
      {
        key = "[t";
        action = "<cmd>tabprevious<CR>";
        options.desc = "Prev tab";
      }
      {
        key = "]t";
        action = "<cmd>tabnext<CR>";
        options.desc = "Next tab";
      }
      {
        key = "<leader>r";
        action = "*:%s//";
        options.desc = "Replace under cursor";
      }
      {
        key = "p";
        action = "\"_dP";
        options.desc = "Better paste";
        mode = ["v"];
      }
      {
        key = "s";
        action = "function() require('flash').jump() end";
        lua = true;
        options.desc = "Run flash";
        mode = ["n" "x"];
      }
      {
        key = "S";
        action = "function() require('flash').treesitter() end";
        lua = true;
        options.desc = "Run flash treesitter";
        mode = ["n" "x"];
      }
      {
        key = "<leader>y";
        action = "function() vim.fn.setreg('*', vim.fn.expand('%:.')) end";
        lua = true;
        options.desc = "Copy current file name";
      }
      {
        key = "<C-d>";
        action = "<C-d>zz";
        options.desc = "Half-page jump down";
      }
      {
        key = "<C-u>";
        action = "<C-u>zz";
        options.desc = "Half-page jump up";
      }
      {
        key = "J";
        action = ":m '>+1<cr>gv=gv";
        options.desc = "move selection down";
        mode = "v";
      }
      {
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "move selection up";
        mode = "v";
      }
      {
        key = "W";
        action = ":noautocmd w<CR>";
        options.desc = "Write without formatting";
      }
      {
        key = "<leader>R";
        action = ":Spectre<CR>";
        options.desc = "Spectre";
      }
      {
        key = "<leader>D";
        action = "ggVGd";
        options.desc = "Blank out file";
      }
      {
        key = "<C-Q>";
        action = "<cmd>qa!<CR>";
        options.desc = "Exit";
      }
      {
        key = "n";
        action = "nzz";
        options.desc = "Recenter search";
      }
      {
        key = "N";
        action = "Nzz";
        options.desc = "Recenter search";
      }
      # resize window
      {
        key = "<S-Up>";
        action = ":resize +2<CR>";
        options.desc = "Increase vertical window size";
      }
      {
        key = "<S-Down>";
        action = ":resize -2<CR>";
        options.desc = "Decrease vertical window size";
      }
      {
        key = "<S-Right>";
        action = ":vertical resize +2<CR>";
        options.desc = "Increase horizontal window size";
      }
      {
        key = "<S-Left>";
        action = ":vertical resize -2<CR>";
        options.desc = "Decrease horizontal window size";
      }
    ];
  };
}
