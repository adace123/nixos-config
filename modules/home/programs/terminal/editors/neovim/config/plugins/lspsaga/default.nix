{
  programs.nixvim = {
    plugins = {
      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>c";
          desc = "code+";
        }
      ];
      lspsaga = {
        enable = true;
        lightbulb.sign = false;
        scrollPreview = {
          scrollDown = "<C-j>";
          scrollUp = "<C-k>";
        };
        finder.keys.toggleOrOpen = "<CR>";
      };
    };
    keymaps = [
      {
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options.desc = "Code action";
      }
      {
        key = "<leader>cr";
        action = "<cmd>Lspsaga rename ++project<CR>";
        options.desc = "Rename word in project";
      }
      {
        key = "K";
        action = "<cmd>Lspsaga hover_doc ++keep<CR>";
        options.desc = "Hover doc";
      }
      {
        key = "<leader>cO";
        action = "<cmd>Lspsaga outline<CR>";
        options.desc = "Toggle outline";
      }
    ];
  };
}
