{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.zig;
  nvim_cfg = config.modules.editors.neovim;
in
  with lib; {
    options.modules.dev.zig.enable = mkEnableOption "zig";
    config = mkIf cfg.enable {
      home.packages =
        [pkgs.zls] ++ (optionals (!nvim_cfg.enable) [pkgs.zig]);

      modules.editors.neovim = mkIf nvim_cfg.enable {
        lsp-servers = ["zls"];
        formatters = ["zigfmt"];
      };

      programs.neovim = mkIf nvim_cfg.enable {
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.zig]))];
      };
    };
  }
