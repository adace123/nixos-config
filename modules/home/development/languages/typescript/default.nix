{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.languages.typescript;
in
with lib;
{
  options.adace.development.languages.typescript.enable = mkEnableOption "Enable Typescript tools";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bun
      nodejs
      typescript
      prettierd
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
