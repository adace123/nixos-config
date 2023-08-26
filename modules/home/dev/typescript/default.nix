{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.typescript;
  nvim_cfg = config.modules.editors.neovim;
in
  with lib; {
    options.modules.dev.typescript.enable = mkEnableOption "Typescript";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        bun
        typescript
      ];

      modules.editors.neovim.languageSupport = mkIf nvim_cfg.enable [
        {
          name = "tsserver";
          command = "${getExe pkgs.nodePackages.typescript-language-server}";
          cmdArgs = ["--stdio"];
          type = "lsp";
        }
        {
          name = "prettier";
          command = "${pkgs.prettierd}/bin/prettierd";
          type = "formatting";
        }
        {
          name = "eslint_d";
          command = "${pkgs.eslint_d}/bin/eslint_d";
          type = "formatting";
        }
      ];

      home.file.".eslintrc".text = builtins.toJSON {
        env = {
          browser = true;
          node = true;
        };
        extends = "eslint:recommended";
      };
    };
  }
