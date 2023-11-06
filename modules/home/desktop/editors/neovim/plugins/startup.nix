{
  programs.nixvim = {
    plugins = {
      auto-session = {
        enable = true;
        autoSave.enabled = true;
      };

      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            opts = {
              hl = "Type";
              position = "center";
            };
            val = [
              "  ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗  "
              "  ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║  "
              "  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║  "
              "  ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║  "
              "  ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║  "
              "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  "
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                command = "<CMD>ene <CR>";
                desc = "  New file";
                shortcut = "e";
              }
              {
                command = "<CMD>:lua require('auto-session.session-lens').search_session()<CR>";
                desc = "  Find Session";
                shortcut = "<leader>sS";
              }
              {
                command = "<CMD>:SessionRestore<CR>";
                desc = "󰦛 Restore Last Session";
                shortcut = "<leader>sr";
              }
              {
                command = "<CMD>:Telescope git_files<CR>";
                desc = "󰱽 Find File";
                shortcut = "<C-p>";
              }
              {
                command = "<CMD>:Telescope live_grep<CR>";
                desc = " Find in Files (grep)";
                shortcut = "<leader>fg";
              }
              {
                command = "<CMD>:Neogit<CR>";
                desc = " Neogit";
                shortcut = "<leader>gg";
              }
              {
                command = ":qa<CR>";
                desc = "󰗼  Quit Neovim";
                shortcut = "<leader>q";
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            opts = {
              hl = "Keyword";
              position = "center";
            };
            val = "Inspiring quote here.";
          }
        ];
      };
    };
  };
}
