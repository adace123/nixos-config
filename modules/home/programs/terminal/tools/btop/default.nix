{
  config,
  lib,

  ...
}:
let
  cfg = config.adace.terminal.tools.btop;
in
with lib;
{
  options.adace.terminal.tools.btop.enable = mkEnableOption "btop";
  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
        temp_scale = "fahrenheit";
      };
    };
  };
}
