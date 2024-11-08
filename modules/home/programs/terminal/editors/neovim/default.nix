{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.editors.neovim;
in
with lib;
{
  imports = [ ./config ];

  options.adace.terminal.editors.neovim.enable = mkEnableOption "neovim";

  config = mkIf cfg.enable {
    home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";

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
