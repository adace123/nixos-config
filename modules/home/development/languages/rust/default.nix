{
  config,
  inputs,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.languages.rust;
in
with lib;
{
  options.adace.development.languages.rust.enable = mkEnableOption "Enable Rust tools";

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
      rustfmt
      rust-analyzer
    ];

    home.file.".cargo/config.toml".text = inputs.nix-std.lib.serde.toTOML {
      target.x86_64-unknown-linux-gnu = {
        linker = "clang";
        rustflags = [
          "-C"
          "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"
        ];
      };

      registries.crates-io = {
        protocol = "sparse";
      };
    };
  };
}
