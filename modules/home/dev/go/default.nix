{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.go;
  nvim_cfg = config.modules.editors.neovim;
in
  with lib; {
    options.modules.dev.go.enable = mkEnableOption "go";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [go gopls gotools];

      modules.editors.neovim = mkIf nvim_cfg.enable {
        lsp-servers = ["gopls"];
        formatters = ["gofmt" "goimports"];
      };

      programs.neovim = mkIf nvim_cfg.enable {
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.go]))];
      };
    };
  }
