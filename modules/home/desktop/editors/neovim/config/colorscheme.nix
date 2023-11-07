{
  programs.nixvim.colorschemes = {
    catppuccin = {
      enable = true;
      flavour = "mocha";
      integrations = {
        cmp = true;
        treesitter = true;
        telescope = true;
        indent_blankline.enabled = true;
        barbar = true;
      };
    };
  };
}
