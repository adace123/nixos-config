{pkgs, ...}: {
  imports = [./lsp.nix ./treesitter.nix ./telescope.nix ./file-explorer.nix ./git.nix ./cmp.nix ./indent-blankline.nix ./lualine.nix ./none-ls.nix ./startup.nix ./lspsaga.nix ./barbar.nix ./neorg.nix ./toggleterm.nix];

  programs.nixvim = {
    plugins = {
      surround.enable = true;
      nvim-ufo.enable = true;
      comment-nvim.enable = true;
      trouble.enable = true;
      luasnip.enable = true;
      flash.enable = true;
      harpoon = {
        enable = true;
        keymapsSilent = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>a";
          toggleQuickMenu = "<leader>h";
          navNext = "]]";
          navPrev = "[[";
        };
      };
      # notify.enable = true;
      nvim-autopairs = {
        enable = true;
        checkTs = true;
      };
      nvim-colorizer.enable = true;
      illuminate.enable = true;
      nix.enable = true;
      todo-comments.enable = true;
      lspkind.enable = true;
      which-key.enable = true;
      better-escape.enable = true;
      undotree.enable = true;
      project-nvim.enable = true;
      # noice.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      overseer-nvim
      plenary-nvim
      nvim-web-devicons
      nvim-spectre
    ];
  };
}
