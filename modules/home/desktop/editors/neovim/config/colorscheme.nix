{pkgs, ...}: {
  programs.nixvim = {
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          integrations = {
            aerial = true;
            barbar = true;
            cmp = true;
            gitsigns = true;
            harpoon = true;
            indent_blankline.enabled = true;
            lsp_saga = true;
            treesitter = true;
            telescope.enabled = true;
          };
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      gruvbox
      nord-nvim
      everforest
      kanagawa-nvim
    ];
  };
}
