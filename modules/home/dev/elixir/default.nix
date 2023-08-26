{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.elixir;
  nvim_cfg = config.modules.editors.neovim;
in
  with lib; {
    options.modules.dev.elixir.enable = mkEnableOption "elixir";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [elixir elixir-ls] ++ (with pkgs.beam.packages.erlang; [livebook]);
      modules.editors.neovim.languageSupport = mkIf nvim_cfg.enable [
        {
          name = "elixirls";
          command = "${pkgs.elixir-ls}/bin/elixir-ls";
          type = "lsp";
          extraConfig = ''
            settings = {
              dialyzerEnabled = true,
            }
          '';
        }
      ];

      programs.neovim = mkIf nvim_cfg.enable {
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.elixir]))];
      };
    };
  }
