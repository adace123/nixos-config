{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.graphical.editors.vscode;
in
with lib;
{
  options.adace.programs.graphical.editors.vscode.enable = mkEnableOption "VS Code";
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      userSettings = {
        editor.fontFamily = "JetBrains Mono";
        editor.fontSize = 14;
        editor.formatOnSave = true;
        terminal.integrated.defaultProfile.linux = "nu";
        terminal.integrated.shell.linux = "${pkgs.kitty}/bin/kitty";
        terminal.external.linuxExec = "${pkgs.kitty}/bin/kitty";
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
      ];
    };
  };
}
