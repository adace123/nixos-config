{
  programs.nixvim = {
    keymaps = [
      {
        key = "kj";
        action = "<Esc>";
        options.desc = "Escape";
        mode = [ "i" ];
      }
      {
        key = "jk";
        action = "<Esc>";
        options.desc = "Escape";
        mode = [ "i" ];
      }
      {
        key = "<Esc>";
        action = ":nohl<CR>";
        options.desc = "No highlight";
      }
      {
        key = "jj";
        action = "<Esc>";
        options.desc = "Escape";
        mode = [ "i" ];
      }
      {
        key = "<C-e>";
        action = "<C-o>$";
        mode = [ "i" ];
      }
      {
        key = "<C-a>";
        action = "<C-o>^";
        mode = [ "i" ];
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
        mode = [ "i" ];
      }
      {
        key = "<C-x>";
        action = "<C-w>q";
        options.desc = "Close window";
      }
      {
        key = "<leader>/";
        action.__raw = ''
          function()
            require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
          end
        '';
        options.desc = "Toggle comment line";
      }
      {
        key = "<leader>/";
        action = ''
          <esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())
        '';
        options.desc = "Toggle comment for selection";
        mode = [ "v" ];
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
        mode = [ "v" ];
      }
      {
        key = "<C-h>";
        action.__raw = "function () require('smart-splits').move_cursor_left() end";
        options.desc = "Navigate left";
      }
      {
        key = "<C-l>";
        action.__raw = "function () require('smart-splits').move_cursor_right() end";
        options.desc = "Navigate right";
      }
      {
        key = "<C-j>";
        action.__raw = "function () require('smart-splits').move_cursor_down() end";
        options.desc = "Navigate down";
      }
      {
        key = "<C-k>";
        action.__raw = "function () require('smart-splits').move_cursor_up() end";
        options.desc = "Navigate up";
      }
      {
        key = "<C-Up>";
        action.__raw = "function () require('smart-splits').resize_up() end";
        options.desc = "Resize up";
      }
      {
        key = "<C-Down>";
        action.__raw = "function () require('smart-splits').resize_down() end";
        options.desc = "Resize down";
      }
      {
        key = "<C-Left>";
        action.__raw = "function () require('smart-splits').resize_left() end";
        options.desc = "Resize left";
      }
      {
        key = "<C-Up>";
        action.__raw = "function () require('smart-splits').resize_right() end";
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
        key = "<leader>Y";
        action = ":%y+<CR>";
        options.desc = "Copy file";
      }
      {
        key = "p";
        action = "\"_dP";
        options.desc = "Better paste";
        mode = [ "v" ];
      }
      {
        key = "s";
        action.__raw = "function() require('flash').jump() end";
        options.desc = "Run flash";
        mode = [
          "n"
          "x"
        ];
      }
      {
        key = "S";
        action.__raw = "function() require('flash').treesitter() end";
        options.desc = "Run flash treesitter";
        mode = [
          "n"
          "x"
        ];
      }
      {
        key = "<leader>y";
        action.__raw = "function() vim.fn.setreg('*', vim.fn.expand('%:.')) end";
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
