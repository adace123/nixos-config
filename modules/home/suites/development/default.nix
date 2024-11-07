{ config, lib, ... }:
let
  cfg = config.adace.suites.development;
in
with lib;
{
  options.adace.suites.development.enable = mkEnableOption "Enable all development options";
  config = mkIf cfg.enable {
    adace = {
      development = {
        languages = {
          elixir.enable = true;
          go.enable = true;
          python.enable = true;
          rust.enable = true;
          typescript.enable = true;
          zig.enable = true;
        };
        tools = {
          iac.enable = true;
          kubernetes.enable = true;
          nix.enable = true;
          git.enable = true;
        };
      };
      terminal = {
        editors = {
          helix.enable = true;
          neovim.enable = true;
        };
      };
    };
  };
}
