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
        rustc
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

      modules.editors.neovim.languageSupport = mkIf nvim_cfg.enable [
        {
          name = "rust_analyzer";
          package = pkgs.rust-analyzer;
          type = "lsp";
        }
        {
          name = "rustfmt";
          package = pkgs.rustfmt;
          type = "formatting";
        }
      ];

      programs.neovim = mkIf nvim_cfg.enable {
        extraPackages = with pkgs; [rust-analyzer];
        plugins = with pkgs.vimPlugins; [(nvim-treesitter.withPlugins (p: [p.rust]))];
      };
    };
  }
