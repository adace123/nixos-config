{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.social.discord;
  catppuccin-macchiato = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "0f2c393b11dd8174002803835ef7640635100ca3";
    hash = "sha256-iUnLLAQVMXFLyoB3wgYqUTx5SafLkvtOXK6C8EHK/nI=";
  };
in
  with lib; {
    options.modules.desktop.social.discord.enable = mkEnableOption "discord";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [webcord-vencord discordo];

      xdg.configFile = {
        "WebCord/Themes/mocha" = {
          source = "${catppuccin-macchiato}/themes/mocha.theme.css";
        };
      };
    };
  }
