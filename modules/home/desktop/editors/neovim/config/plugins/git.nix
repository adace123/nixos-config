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
      }
      {
        key = "<leader>gR";
        action = "<cmd>Gitsigns reset_buffer<CR>";
        options.desc = "Reset buffer";
      }
      {
        key = "<leader>gs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options.desc = "Stage hunk";
      }
      {
        key = "<leader>gu";
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        options.desc = "Undo stage hunk";
      }
      {
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options.desc = "LazyGit";
      }
      {
        key = "<leader>gS";
        # Gitsigns stage_buffer does not work for new files
        action = "<cmd>silent !git add %<CR>";
        options.desc = "Stage buffer";
      }
      {
        key = "]]";
        action.__raw = "function() require('gitsigns').next_hunk({navigation_message = false}) end";
        options.desc = "Next Git hunk";
      }
      {
        key = "[[";
        action.__raw = "function() require('gitsigns').prev_hunk({navigation_message = false}) end";
        options.desc = "Prev Git hunk";
      }
      {
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<CR>";
        options.desc = "Preview hunk";
      }
      {
        key = "<leader>gl";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options.desc = "Blame";
      }
      {
        key = "<leader>gd";
        action.__raw = ''
          function()
            local lib = require("diffview.lib")
            local view = lib.get_current_view()
            if view then
              -- Current tabpage is a Diffview; close it
              vim.cmd.DiffviewClose()
            else
              -- No open Diffview exists: open a new one
              vim.cmd.DiffviewOpen()
            end
          end
        '';
        options.desc = "Diff";
      }
      {
        key = "<leader>gh";
        action = "<cmd>DiffviewFileHistory<CR>";
        options.desc = "File history";
      }
    ];
  };
}
