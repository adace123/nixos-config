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
      modules.editors.neovim = mkIf nvim_cfg.enable {
        lsp-servers = ["elixirls"];
        formatters = ["credo"];
      };

      programs.neovim = mkIf nvim_cfg.enable {
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.elixir]))];
      };

      home.file.".config/astronvim/lua/user/lsp/config/elixirls.lua".text = mkIf nvim_cfg.enable ''
        return {
          cmd = { "${pkgs.elixir-ls}/bin/elixir-ls" },
          settings = {
            dialyzerEnabled = true,
          }
        }
      '';
    };
  }
