{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.neofetch;
  neofetch_themes = pkgs.fetchFromGitHub {
    owner = "Chick2D";
    repo = "neofetch-themes";
    rev = "main";
    hash = "sha256-btK1TZg49bASOFxQDY5edE0QM+iSsTQmJko4AiyYlpY=";
  };
in
  with lib; {
    options.modules.shell.neofetch.enable = mkEnableOption "neofetch";
    config = mkIf cfg.enable {
      home.packages = [
        pkgs.neofetch
      ];

      xdg.configFile."neofetch/config.conf".source = "${neofetch_themes}/normal/ozozfetch.conf";
    };
  }
