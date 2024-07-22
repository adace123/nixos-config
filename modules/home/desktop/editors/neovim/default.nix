{
  config,
  lib,
  ...
}: let
  cfg = config.modules.editors.neovim;
in
  with lib; {
    imports = [./config];

    options.modules.editors.neovim.enable = mkEnableOption "neovim";

    config = mkIf cfg.enable {
      home.sessionVariables.EDITOR = "nvim";
      programs.nushell.extraConfig = ''$env.EDITOR = "nvim"'';

      programs.nixvim = {
        enable = true;
        clipboard.providers = {
          wl-copy.enable = true;
          xclip.enable = true;
        };
        luaLoader.enable = true;
      };
    };
  }
