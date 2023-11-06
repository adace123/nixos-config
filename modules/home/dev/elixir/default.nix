{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.elixir;
in
  with lib; {
    options.modules.dev.elixir.enable = mkEnableOption "elixir";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [elixir elixir-ls] ++ (with pkgs.beam.packages.erlang; [livebook]);
    };
  }
