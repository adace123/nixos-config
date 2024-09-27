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
      programs = {
        terminal = {
          emulators = {
            kitty.enable = true;
          };
          editors = {
            helix.enable = true;
            neovim.enable = true;
          };
          shells.nushell.enable = true;
          tools = {
            aichat.enable = true;
            btop.enable = true;
            direnv.enable = true;
            fastfetch.enable = true;
            lazygit.enable = true;
            modern-unix.enable = true;
            starship.enable = true;
            tgpt.enable = true;
            yazi.enable = true;
          };
        };
        graphical = {
          editors.vscode.enable = true;
        };
      };
    };
  };
}
