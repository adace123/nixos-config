{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    formatOnSave = {
      lspFallback = true;
      timeoutMs = 500;
    };
    formattersByFt = {
      bash = ["shellcheck" "shfmt"];
      go = ["gofmt"];
      json = ["fix_json" "prettierd"];
      just = ["just"];
      lua = ["stylua"];
      markdown = ["markdownlint"];
      nix = ["alejandra"];
      python = ["ruff_format"];
      rust = ["rustfmt"];
      tf = ["terraform_fmt"];
      terraform = ["terraform_fmt"];
      toml = ["taplo"];
      typescript = ["prettierd" "prettier"];
      yaml = ["yamllint" "yamlfmt"];
      zig = ["zigfmt"];
    };
  };
}
