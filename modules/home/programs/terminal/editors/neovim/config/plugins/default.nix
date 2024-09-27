{ pkgs, ... }:
{
  imports = [
    ./aerial.nix
    ./bufferline.nix
    ./cmp.nix
    ./conform.nix
    ./dap.nix
    ./file-explorer.nix
    ./git.nix
    ./kitty.nix
    ./lsp.nix
    ./lspsaga.nix
    ./lualine.nix
    ./neotest.nix
    ./noice.nix
    ./ollama.nix
    ./obsidian.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
  ];

  programs.nixvim = {
    plugins = {
      mini = {
        enable = true;
        modules = {
          indentscope = {
            symbol = "│";
            options = {
              border = "top";
              indent_at_cursor = true;
              try_as_border = true;
            };
          };
        };
      };
      vim-surround.enable = true;
      nvim-ufo.enable = true;
      neoclip.enable = true;
      bufdelete.enable = true;
      comment.enable = true;
      luasnip.enable = true;
      flash.enable = true;
      headlines.enable = true;
      harpoon = {
        enable = true;
        keymapsSilent = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>A";
          toggleQuickMenu = "<leader>h";
          navNext = "]h";
          navPrev = "[h";
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
      which-key.enable = true;
      better-escape.enable = true;
      undotree.enable = true;
      spectre.enable = true;
      auto-session = {
        enable = true;
        autoRestore.enabled = true;
        autoSave.enabled = true;
        # autoSession.enableLastSession = true;
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-web-devicons
    ];
  };
}
