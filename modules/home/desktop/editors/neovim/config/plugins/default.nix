{pkgs, ...}: {
  imports = [
    ./aerial.nix
    ./bufferline.nix
    ./cmp.nix
    ./conform.nix
    ./file-explorer.nix
    ./git.nix
    ./indent-blankline.nix
    ./kitty.nix
    ./lsp.nix
    ./lspsaga.nix
    ./lualine.nix
    ./noice.nix
    ./ollama.nix
    ./obsidian.nix
    ./startup.nix
    ./telescope.nix
    ./treesitter.nix
    ./toggleterm.nix
  ];

  programs.nixvim = {
    plugins = {
      surround.enable = true;
      nvim-ufo.enable = true;
      neoclip.enable = true;
      bufdelete.enable = true;
      comment.enable = true;
      trouble = {
        enable = true;
        settings = {
          mode = "document_diagnostics";
          position = "right";
        };
      };
      luasnip.enable = true;
      flash.enable = true;
      headlines.enable = true;
      markdown-preview.enable = true;
      harpoon = {
        enable = true;
        keymapsSilent = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>A";
          toggleQuickMenu = "<leader>h";
          navNext = "]]";
          navPrev = "[[";
        };
      };
      nvim-autopairs = {
        enable = true;
        settings.check_ts = true;
      };
      nvim-colorizer.enable = true;
      illuminate.enable = true;
      nix.enable = true;
      todo-comments.enable = true;
      lspkind.enable = true;
      which-key.enable = true;
      better-escape.enable = true;
      undotree.enable = true;
      #spectre.enable = true;
      persistence.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-web-devicons
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
}
