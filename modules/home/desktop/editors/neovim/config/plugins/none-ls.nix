{
  programs.nixvim = {
    plugins = {
      lsp-format.enable = true;
      none-ls = {
        enable = true;
        sources = {
          formatting = {
            alejandra.enable = true;
            black.enable = true;
            isort.enable = true;
            gofmt.enable = true;
            stylua.enable = true;
            shfmt.enable = true;
          };
          diagnostics = {
            deadnix.enable = true;
            mypy.enable = true;
            statix.enable = true;
            yamllint.enable = true;
          };
        };
      };
    };
  };
}
