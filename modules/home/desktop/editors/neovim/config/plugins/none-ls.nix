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
            rustfmt.enable = true;
            stylua.enable = true;
            shfmt.enable = true;
            taplo.enable = true;
            # prettier.enable = true;
            eslint_d.enable = true;
          };
          diagnostics = {
            deadnix.enable = true;
            eslint_d.enable = true;
            ruff.enable = true;
            shellcheck.enable = true;
            statix.enable = true;
            yamllint.enable = true;
          };
        };
      };
    };
  };
}
