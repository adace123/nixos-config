{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      separatorStyle = "slant";
      diagnostics = "nvim_lsp";
      offsets = [
        {
          filetype = "neo-tree";
          text = "File Explorer";
          text_align = "center";
          separator = false;
        }
      ];
    };
    keymaps = [
      {
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<CR>";
        options.desc = "Next buffer";
      }
      {
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        options.desc = "Previous buffer";
      }
      {
        key = "<S-x>";
        action = "<cmd>Bdelete<CR>";
        options.desc = "Close buffer";
      }
      {
        key = "<leader>bd";
        action = "<cmd>BufferLinePickClose<CR>";
        options.desc = "Pick buffer to close";
      }
      {
        key = "<TAB>";
        action = "<cmd>BufferLineCycleNext<CR>";
        options.desc = "Next buffer";
      }
      {
        key = "<S-TAB>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        options.desc = "Previous buffer";
      }
    ];
  };
}
