{pkgs, ...}: {
  imports = [
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./barbar.nix
    ./git.nix
    ./file-explorer.nix
    ./indent-blankline.nix
    ./lspsaga.nix
    ./lualine.nix
    ./neorg.nix
    ./none-ls.nix
    ./startup.nix
    ./toggleterm.nix
    ./cmp.nix
  ];

  programs.nixvim = {
    plugins = {
      surround.enable = true;
      nvim-ufo.enable = true;
      comment.enable = true;
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
    };
    extraPlugins = with pkgs.vimPlugins; [
      overseer-nvim
      plenary-nvim
      nvim-web-devicons
      nvim-spectre
      persistence-nvim
    ];
    userCommands = {
      SessionRestore = {
        nargs = "*";
        command = ":lua require('persistence').load()";
      };
      LastSessionRestore = {
        nargs = "*";
        command = ":lua require('persistence').load({ last = true })";
      };
    };
  };

  # autoCmd = [
  #   {
  #     event = "BufReadPre";
  #     command = ":lua require('persistence').save()";
  #   }
  # ];
}
