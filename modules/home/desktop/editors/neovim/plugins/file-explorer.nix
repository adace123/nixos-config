{
  programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;
      diagnostics.enable = true;
      git.enable = true;
      reloadOnBufenter = true;
      respectBufCwd = true;
    };
    keymaps = [
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<leader>e";
        options.desc = "Neotree";
        mode = ["n"];
      }
    ];
  };
}
