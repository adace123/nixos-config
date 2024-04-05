{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      gitsigns.enable = true;
      which-key.registrations = {
        "<leader>g" = "+git";
      };
    };
    extraPlugins = [pkgs.vimPlugins.lazygit-nvim];
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
        key = "]h";
        action = "function() require('gitsigns').next_hunk({navigation_message = false}) end";
        options.desc = "Next hunk";
        lua = true;
        mode = ["n"];
      }
      {
        key = "[h";
        action = "function() require('gitsigns').prev_hunk({navigation_message = false}) end";
        lua = true;
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
        action = "<cmd>Gitsigns diffthis<CR>";
        options.desc = "Diff";
        mode = ["n"];
      }
    ];
  };
}
