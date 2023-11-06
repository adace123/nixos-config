{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.vscode;
in
  with lib; {
    options.modules.editors.vscode.enable = mkEnableOption "VS Code";
    config = mkIf cfg.enable {
      home.packages = [pkgs.vscodium];
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        userSettings = {
          editor.fontFamily = "JetBrains Mono";
          editor.fontSize = 18;
          editor.formatOnSave = true;
          terminal.integrated.defaultProfile.linux = "nu";
          terminal.integrated.shell.linux = "${pkgs.alacritty}/bin/alacritty";
          terminal.external.linuxExec = "${pkgs.alacritty}/bin/alacritty";
          vim.useSystemClipboard = true;
          window.titleBarStyle = "custom";
          window.zoomLevel = 1;
          workbench.colorTheme = "Catppuccin Mocha";
        };
        extensions = with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer
          vscodevim.vim
          #ms-python.python
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          golang.go
          rust-lang.rust-analyzer
          esbenp.prettier-vscode
        ];
      };
    };
  }
