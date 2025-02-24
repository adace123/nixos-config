_: {
  programs.nixvim = {
    plugins = {
      vim-surround.enable = true;
      nvim-ufo.enable = true;
      neoclip.enable = true;
      comment.enable = true;
      flash.enable = true;
      headlines.enable = true;
      nvim-autopairs = {
        enable = true;
        settings.check_ts = true;
      };
      dropbar.enable = true;
      inc-rename.enable = true;
      colorizer.enable = true;
      illuminate.enable = true;
      nix.enable = true;
      todo-comments.enable = true;
      which-key.enable = true;
      better-escape.enable = true;
      spectre.enable = true;
      auto-session = {
        enable = true;
        settings = {
          autoRestore.enabled = true;
          autoSave.enabled = true;
        };
      };
      web-devicons.enable = true;
    };
  };
}
