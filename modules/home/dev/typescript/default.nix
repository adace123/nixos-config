{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.typescript;
in
  with lib; {
    options.modules.dev.typescript.enable = mkEnableOption "Typescript";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        bun
        typescript
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
