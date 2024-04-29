{pkgs, ...}: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      settings = {
        defaults = {
          mappings = {
            i = {
              "<Esc>" = "close";
            };
          };
        };
        pickers.buffers = {
          show_all_buffers = "true";
          show_lastused = "true";
          theme = "dropdown";
          mappings = {
            i = {
              "<C-d>" = "delete_buffer";
            };
            n = {
              "dd" = "delete_buffer";
            };
          };
        };
      };
      keymaps = {
        "<leader>fb" = {
          action = "buffers";
          options = {
            silent = true;
            desc = "Buffers";
          };
        };
        "<leader>fd" = {
          action = "diagnostics";
          options = {
            silent = true;
            desc = "LSP Diagnostics";
          };
        };
        "<leader>ff" = {
          action = "find_files";
          options = {
            silent = true;
            desc = "Files";
          };
        };
        "<leader>fk" = {
          action = "keymaps";
          options = {
            silent = true;
            desc = "Keymaps";
          };
        };
        "<leader>fj" = {
          action = "jumplist";
          options = {
            silent = true;
            desc = "Jumplist";
          };
        };
        "<leader>fo" = {
          action = "oldfiles";
          options = {
            silent = true;
            desc = "Recent files";
          };
        };
        "<leader>fc" = {
          action = "command_history";
          options = {
            silent = true;
            desc = "Command history";
          };
        };
        "<leader>fW" = {
          action = "grep_string";
          options = {
            silent = true;
            desc = "Search word under cursor";
          };
        };
        "<leader>ci" = {
          action = "lsp_incoming_calls";
          options = {
            silent = true;
            desc = "Incoming calls";
          };
        };
        "<leader>co" = {
          action = "lsp_outgoing_calls";
          options = {
            silent = true;
            desc = "Outgoing calls";
          };
        };
        "<leader>f" = {
          action = "grep_string";
          options = {
            silent = true;
            desc = "Visual grep";
          };
          mode = ["v"];
        };
      };
      extensions = {
        fzf-native.enable = true;
      };
    };
    keymaps = [
      {
        key = "<leader>fh";
        action = ":Telescope harpoon marks<CR>";
        options.desc = "Harpoon";
        mode = ["n"];
      }
      {
        key = "<leader>fC";
        action = "function() require('telescope.builtin').colorscheme({ enable_preview = true }) end";
        lua = true;
        options.desc = "Colorscheme";
        mode = ["n"];
      }
      {
        key = "<leader>fw";
        action = "function() require('telescope.builtin').live_grep({ find_command = {'rg', '--smart-case'} }) end";
        lua = true;
        options.desc = "Live grep";
        mode = ["n"];
      }
      {
        key = "<leader>fy";
        action = ":Telescope neoclip<CR>";
        options.desc = "Clipboard history";
      }
      {
        key = "<leader>fm";
        action = "function() require('telescope').extensions.marks_nvim.marks_list_all() end";
        lua = true;
        options.desc = "Marks";
      }
    ];
    extraPlugins = [pkgs.vimPlugins.telescope-live-grep-args-nvim];
  };
}
