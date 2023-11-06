{
  config,
  lib,
  pkgs,
  std,
  ...
}: let
  cfg = config.modules.dev.rust;
in
  with lib; {
    options.modules.dev.rust.enable = mkEnableOption "Rust";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        cargo
        cargo-edit
        cargo-generate
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
    };
  }
