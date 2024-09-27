{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      settings = {
        defaults = {
          mappings = {
            i = {
              "<esc>" = "close";
              "<C-x>" = "close";
              "<C-j>" = "move_selection_next";
              "<C-k>" = "move_selection_previous";
              "<C-/>" = "which_key";
              "<C-u>" = false;
              "<C-d>" = false;
              "<C-e>" = "results_scrolling_down";
              "<C-y>" = "results_scrolling_up";
              "<C-U>" = "preview_scrolling_up";
              "<C-D>" = "preview_scrolling_down";
              "<C-q>".__raw = "require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist";
            };
          };
        };
        pickers.find_files = {
          hidden = true;
          file_ignore_patterns = [ "%.git/.*" ];
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
        "<leader>fg" = {
          action = "git_status";
          options = {
            silent = true;
            desc = "Git status";
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
        "<leader>fs" = {
          action = "session-lens";
          options = {
            silent = true;
            desc = "Sessions";
          };
        };
        "<leader>fm" = {
          action = "marks";
          options = {
            silent = true;
            desc = "Marks";
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
          mode = [ "v" ];
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
      }
      {
        key = "<leader>fC";
        action.__raw = "function() require('telescope.builtin').colorscheme({ enable_preview = true }) end";
        options.desc = "Colorscheme";
      }
      {
        key = "<leader>fw";
        action.__raw = "function() require('telescope.builtin').live_grep({ find_command = {'rg', '-S'} }) end";
        options.desc = "Live grep";
      }
      {
        key = "<leader>fy";
        action = ":Telescope neoclip<CR>";
        options.desc = "Clipboard history";
      }
      {
        key = "<leader>fb";
        action = ":Telescope dap list_breakpoints<CR>";
        options.desc = "Breakpoints";
      }
      {
        key = "<leader>ft";
        action = ":TodoTelescope<CR>";
        options.desc = "Todos";
      }
      {
        key = "<leader><space>";
        action = ":Telescope find_files<CR>";
        options.desc = "Files";
      }
      {
        key = "<leader>b";
        action = ":Telescope buffers<CR>";
        options.desc = "Buffers";
      }
      {
        key = "<leader>w";
        action.__raw = "function() require('telescope.builtin').live_grep({ find_command = {'rg', '-S'} }) end";

        options.desc = "Live grep";
      }
    ];
    extraPlugins = with pkgs.vimPlugins; [
      telescope-live-grep-args-nvim
      telescope-dap-nvim
    ];
    extraConfigLua = ''
      require("telescope").load_extension('dap')
    '';
  };
}
