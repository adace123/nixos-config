{
  programs.nixvim = {
    plugins.barbar = {
      enable = true;
      animation = true;
      clickable = true;
      semanticLetters = true;
    };
    keymaps = [
      {
        key = "<S-h>";
        action = "<cmd>BufferPrevious<CR>";
        options.desc = "Previous buffer";
        mode = ["n"];
      }
      {
        key = "<S-l>";
        action = "<cmd>BufferNext<CR>";
        options.desc = "Next buffer";
        mode = ["n"];
      }
      {
        key = "<S-x>";
        action = "<cmd>BufferClose<CR>";
        options.desc = "Close buffer";
        mode = ["n"];
      }
      {
        key = "<leader>br";
        action = "<cmd>BufferRestore<CR>";
        options.desc = "Restore buffer";
        mode = ["n"];
      }
      {
        key = "<leader>bd";
        action = "<cmd>BufferPickDelete<CR>";
        options.desc = "Pick buffer to close";
        mode = ["n"];
      }
      {
        key = "<TAB>";
        action = "<cmd>BufferNext<CR>";
        options.desc = "Next buffer";
        mode = ["n"];
      }
      {
        key = "<S-TAB>";
        action = "<cmd>BufferPrevious<CR>";
        options.desc = "Previous buffer";
        mode = ["n"];
      }
    ];
  };
}
