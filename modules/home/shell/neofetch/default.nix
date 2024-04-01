{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.neofetch;
in
  with lib; {
    options.modules.shell.neofetch.enable = mkEnableOption "neofetch";
    config = mkIf cfg.enable {
      home.packages = [
        pkgs.neofetch
        pkgs.fastfetch
      ];

      xdg.configFile."neofetch/config.conf".source = ./neofetch.conf;
      programs.nushell.extraConfig = ''
        fastfetch
      '';
    };
  }
