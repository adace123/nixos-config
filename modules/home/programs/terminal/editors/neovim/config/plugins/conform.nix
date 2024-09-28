{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      markdownlint-cli
      nixfmt-rfc-style
      nodePackages.fixjson
      prettierd
      ruff
      rustfmt
      shellcheck
      shfmt
      stylua
      taplo
      yamlfmt
      yamllint
    ];

    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
        formatters_by_ft = {
          bash = [
            "shellcheck"
            "shfmt"
          ];
          go = [ "gofmt" ];
          json = [
            "fix_json"
            "prettierd"
          ];
          just = [ "just" ];
          lua = [ "stylua" ];
          markdown = [ "markdownlint" ];
          nix = [ "nixfmt" ];
          python = [
            "ruff_format"
            "ruff_organize_imports"
            # "ruff_fix" TODO: Uncomment once fixed
          ];
          rust = [ "rustfmt" ];
          tf = [ "terraform_fmt" ];
          terraform = [ "terraform_fmt" ];
          toml = [ "taplo" ];
          typescript = [ "prettierd" ];
          yaml = [
            "yamllint"
            "yamlfmt"
          ];
          zig = [ "zigfmt" ];
        };
      };
    };
  };
}
