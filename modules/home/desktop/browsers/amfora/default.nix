{
  config,
  lib,
  std,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.browsers.amfora;
in
  with lib; {
    options.modules.desktop.browsers.amfora.enable = mkEnableOption "amfora gemini browser";
    config = mkIf cfg.enable {
      home.packages = [pkgs.amfora];
      home.file.".local/share/amfora/bookmarks.xml".source = ./bookmarks.xml;
      home.file.".config/amfora/config.toml".text = std.serde.toTOML {
        keybindings = {
          bind_back = "H";
          bind_forward = "L";
          bind_next_tab = "J";
          bind_prev_tab = "K";
          bind_edit = "o";
          bind_new_tab = "O";
          bind_home = "h";
          bind_bookmarks = "b";
          bind_add_bookmark = "B";
        };
      };
    };
  }
