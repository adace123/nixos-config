{
  programs.nixvim = {
    plugins.neotest = {
      enable = true;
      adapters = {
        go.enable = true;
        python = {
          settings =
            {
            };
        };
        python.enable = true;
        rust.enable = true;
      };
      settings = {
        output.open_on_run = true;
        status.virtual_text = true;
        diagnostic.severity = "hint";
        # Copied from the docs for easy reference
        summary.mappings = {
          attach = "a";
          clear_marked = "M";
          clear_target = "T";
          debug = "d";
          debug_marked = "D";
          expand = [
            "<CR>"
            "<Tab>"
          ];
          expand_all = "e";
          jumpto = "i";
          mark = "m";
          next_failed = "J";
          output = "o";
          prev_failed = "K";
          run = "r";
          run_marked = "R";
          short = "O";
          stop = "u";
          target = "t";
          watch = "w";
        };
      };
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>t";
        desc = "+test";
      }
    ];
    keymaps = [
      {
        key = "<leader>tf";
        action = "<cmd>Neotest run file<CR>";
        options.desc = "Run file";
      }
      {
        key = "<leader>tt";
        action.__raw = "function() require('neotest').run.run({strategy = 'dap'}) end";
        options.desc = "Run nearest";
      }
      {
        key = "<leader>ts";
        action = "<cmd>Neotest summary toggle<CR>";
        options.desc = "Toggle summary panel";
      }
      {
        key = "<leader>to";
        action.__raw = "function() require('neotest').output.open({ enter = true, auto_close = true }) end";
        options.desc = "Show output";
      }
      {
        key = "<leader>tO";
        action = "<cmd>Neotest output-panel toggle<CR>";
        options.desc = "Toggle output panel";
      }
      {
        key = "<leader>tl";
        action = "<cmd>Neotest run last<CR>";
        options.desc = "Run last";
      }
      {
        key = "<leader>tS";
        action.__raw = "require('neotest').run.stop";
        options.desc = "Cancel run";
      }
    ];
  };
}
