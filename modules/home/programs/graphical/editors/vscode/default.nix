{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.editors.vscode;
in
with lib;
{
  options.adace.desktop.editors.vscode.enable = mkEnableOption "VS Code";
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      userSettings = {
        editor.fontFamily = "JetBrains Mono";
        editor.fontSize = 14;
        editor.formatOnSave = true;
        terminal.integrated.defaultProfile.linux = "nu";
        terminal.integrated.shell.linux = toString pkgs.nushell;
        vim.useSystemClipboard = true;
        window.titleBarStyle = "custom";
        window.zoomLevel = 1;
        workbench.colorTheme = "Catppuccin Mocha";
      };
      extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        vscodevim.vim
        ms-python.python
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        golang.go
        esbenp.prettier-vscode
        github.copilot
        github.copilot-chat
        RooVeterinaryInc.roo-cline
      ];
    };
  };
}
