{
  config,
  inputs,
  lib,
  pkgs,
  std,
  ...
}: let
  cfg = config.modules.dev.rust;
  nvim_cfg = config.modules.editors.neovim;
in
  with lib; {
    options.modules.dev.rust.enable = mkEnableOption "Rust";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        cargo
        cargo-edit
        cargo-watch
        cargo-xbuild
        clang
        mold
        rust-analyzer
        rustc
        rustfmt
      ];

      home.file.".cargo/config.toml".text = std.serde.toTOML {
        target.x86_64-unknown-linux-gnu = {
          linker = "clang";
          rustflags = ["-C" "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"];
        };

        registries.crates-io = {
          protocol = "sparse";
        };
      };

      modules.editors.neovim = mkIf nvim_cfg.enable {
        lsp-servers = ["rust_analyzer"];
        formatters = ["rustfmt"];
      };

      home.file.".config/astronvim/lua/user/lsp/config/rust_analyzer.lua".text = mkIf nvim_cfg.enable ''
        return {
          cmd = { "${pkgs.rust-analyzer}/bin/rust-analyzer" }
        }
      '';

      programs.neovim = mkIf nvim_cfg.enable {
        extraPackages = with pkgs; [rust-analyzer];
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.rust]))];
      };
    };
  }
