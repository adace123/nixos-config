{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      alejandra
      markdownlint-cli
      nodePackages.fixjson
      prettierd
      rustfmt
      shfmt
      stylua
      taplo
      yamlfmt
      yamllint
    ];
    plugins.conform-nvim = {
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
        python = ["ruff_fix" "ruff_format" "ruff_organize_imports"];
        rust = ["rustfmt"];
        tf = ["terraform_fmt"];
        terraform = ["terraform_fmt"];
        toml = ["taplo"];
        typescript = ["prettierd"];
        yaml = ["yamllint" "yamlfmt"];
        zig = ["zigfmt"];
      };
    };
  };
}
