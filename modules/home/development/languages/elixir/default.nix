{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.languages.elixir;
in
with lib;
{
  options.adace.development.languages.elixir.enable = mkEnableOption "Enable Elixir tools";
  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        elixir
        elixir-ls
      ]
      ++ (with pkgs.beam.packages.erlang; [ livebook ]);
  };
}
