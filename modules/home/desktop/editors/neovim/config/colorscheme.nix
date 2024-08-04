{pkgs, ...}: {
  programs.nixvim = {
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          styles = {
            booleans = ["bold" "italic"];
            conditionals = ["bold"];
            functions = ["bold"];
            keywords = ["italic"];
            loops = ["bold"];
            operators = ["bold"];
            properties = ["italic"];
          };
          integrations = {
            aerial = true;
            cmp = true;
            gitsigns = true;
            harpoon = true;
            indent_blankline = {
              enabled = true;
              colored_indent_levels = true;
            };
            lsp_saga = true;
            treesitter = true;
            telescope.enabled = true;
            which_key = true;
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
      nightfox-nvim
    ];
  };
}
