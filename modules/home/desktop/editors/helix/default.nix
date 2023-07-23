{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.helix;
in
  with lib; {
    options.modules.editors.helix.enable = mkEnableOption "Helix editor";
    config = mkIf cfg.enable {
      programs.helix = {
        enable = true;
        languages = {
          language-server.nixd.command = "${pkgs.nixd}/bin/nixd";
          language = [
            {
              name = "nix";
              formatter.command = "${pkgs.alejandra}/bin/alejandra";
              auto-format = true;
            }
          ];
        };
        settings = {
          theme = "catppuccin_mocha";
          editor = {
            bufferline = "always";
            color-modes = true;
            rainbow-brackets = true;
            indent-guides = {
              render = true;
              rainbow-option = "dim";
            };
            lsp = {
              display-messages = true;
              display-inlay-hints = true;
            };
          };
          keys.normal = {
            C-h = "jump_view_left";
            C-j = "jump_view_down";
            C-k = "jump_view_up";
            C-l = "jump_view_right";
            C-s = ":w";
          };
          keys.insert = {
            C-s = ":w";
          };
        };
      };
    };
  }
