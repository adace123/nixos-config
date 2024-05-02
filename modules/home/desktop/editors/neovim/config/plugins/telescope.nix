{pkgs, ...}: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      settings = {
        defaults = {
          mappings = {
            i = {
              "<esc>" = "close";
              "<C-x>" = "close";
              "<tab>" = "move_selection_next";
              "<s-tab>" = "move_selection_previous";
              "<C-/>" = "which_key";
              "<C-u>" = "results_scrolling_up";
              "<C-d>" = "results_scrolling_down";
              "<C-U>" = "preview_scrolling_up";
              "<C-D>" = "preview_scrolling_down";
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
        "<leader>." = {
          action = "resume";
          options = {
            silent = true;
            desc = "Repeat last query";
          };
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
      {
        key = "<leader><space>";
        action = ":Telescope buffers theme=dropdown<CR>";
        options.desc = "Buffers";
      }
    ];
    extraPlugins = [pkgs.vimPlugins.telescope-live-grep-args-nvim];
  };
}
