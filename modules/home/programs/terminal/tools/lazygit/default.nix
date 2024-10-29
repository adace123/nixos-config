{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.terminal.tools.lazygit;

in
with lib;
{
  options.adace.terminal.tools.lazygit.enable = mkEnableOption "lazygit";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ delta ];
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          parseEmoji = true;
          paging = {
            colorArg = "always";
            pager = "delta --color-only --paging=never";
          };
        };
      };
    };
  };
}
