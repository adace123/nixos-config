{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        skip_confirm_for_simple_edits = true;
        view_options = {
          show_hidden = true;
        };
        keymaps = {
          q = "actions.close";
          h = "actions.parent";
          l = "actions.select";
          s = "actions.select_vsplit";
          yy = "actions.yank_entry";
        };
        float = {
          padding = 10;
          max_width = 70;
          win_options = {
            winblend = 0;
          };
        };
      };
    };
    # Disable once Snacks explorer has cut functionality
    plugins.neo-tree = {
      enable = true;
      addBlankLineAtTop = true;
      closeIfLastWindow = true;
      enableDiagnostics = true;
      enableGitStatus = true;
      autoCleanAfterSessionRestore = true;
      window.mappings = {
        "e".__raw = "function() vim.api.nvim_exec('Neotree filesystem', true) end";
        "b".__raw = "function() vim.api.nvim_exec('Neotree buffers', true) end";
        "g".__raw = "function() vim.api.nvim_exec('Neotree git_status', true) end";
      };
      filesystem = {
        followCurrentFile.enabled = true;
        filteredItems = {
          visible = true;
          hideHidden = false;
          hideDotfiles = false;
          hideByName = [
            ".git"
            ".node_modules"
          ];
        };
      };
    };
    keymaps = [
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Neotree";
      }
      {
        key = "-";
        action = "<cmd>Oil --float<CR>";
        options.desc = "Oil";
      }
    ];
  };
}
