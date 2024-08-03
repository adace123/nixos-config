{
  programs.nixvim = {
    plugins = {
      gitsigns.enable = true;
      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>g";
          desc = "+git";
        }
      ];
      lazygit.enable = true;
      diffview.enable = true;
    };
    keymaps = [
      {
        key = "<leader>gr";
        action = "<cmd>Gitsigns reset_hunk<CR>";
        options.desc = "Reset hunk";
        mode = ["n"];
      }
      {
        key = "<leader>gR";
        action = "<cmd>Gitsigns reset_buffer<CR>";
        options.desc = "Reset buffer";
        mode = ["n"];
      }
      {
        key = "<leader>gs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options.desc = "Stage hunk";
        mode = ["n"];
      }
      {
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options.desc = "LazyGit";
        mode = ["n"];
      }
      {
        key = "<leader>gS";
        # Gitsigns stage_buffer does not work for new files
        action = "<cmd>silent !git add %<CR>";
        options.desc = "Stage buffer";
        mode = ["n"];
      }
      {
        key = "]]";
        action.__raw = "function() require('gitsigns').next_hunk({navigation_message = false}) end";
        options.desc = "Next hunk";
        mode = ["n"];
      }
      {
        key = "[[";
        action.__raw = "function() require('gitsigns').prev_hunk({navigation_message = false}) end";
        options.desc = "Prev hunk";
        mode = ["n"];
      }
      {
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<CR>";
        options.desc = "Preview hunk";
        mode = ["n"];
      }
      {
        key = "<leader>gl";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options.desc = "Blame";
        mode = ["n"];
      }
      {
        key = "<leader>gd";
        action = "<cmd>DiffviewOpen<CR>";
        options.desc = "Diff";
        mode = ["n"];
      }
    ];
  };
}
