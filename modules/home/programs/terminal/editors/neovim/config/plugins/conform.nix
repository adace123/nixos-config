{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      markdownlint-cli
      nixfmt-rfc-style
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
      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        formattersByFt = {
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
            "ruff_fix"
            "ruff_format"
            "ruff_organize_imports"
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
