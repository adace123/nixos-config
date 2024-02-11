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
      home.file.".config/amfora/config.toml".text = with config.colorScheme.palette;
        std.serde.toTOML {
          theme = {
            bg = "#${base00}";
            tab_num = "#${base0E}";
            tab_divider = "#${base03}";
            bottombar_label = "#${base0E}";
            bottombar_text = "#${base05}";
            bottombar_bg = "#${base01}";
            scrollbar = "#${base02}";
            hdg_1 = "#${base0B}";
            hdg_2 = "#${base0B}";
            hdg_3 = "#${base0B}";
            amfora_link = "#${base0A}";
            foreign_link = "#${base0D}";
            link_number = "#${base04}";
            regular_text = "#${base05}";
            quote_text = "#${base0C}";
            preformatted_text = "#${base05}";
            list_text = "#${base05}";
            btn_bg = "#${base0C}";
            btn_text = "#${base05}";
            dl_choice_modal_bg = "#${base01}";
            dl_choice_modal_text = "#${base05}";
            dl_modal_bg = "#${base01}";
            dl_modal_text = "#${base05}";
            info_modal_bg = "#${base01}";
            info_modal_text = "#${base05}";
            error_modal_bg = "#${base01}";
            error_modal_text = "#${base09}";
            yesno_modal_bg = "#${base01}";
            yesno_modal_text = "#${base05}";
            tofu_modal_bg = "#${base01}";
            tofu_modal_text = "#${base05}";
            subscription_modal_bg = "#${base01}";
            subscription_modal_text = "#${base05}";
            input_modal_bg = "#${base01}";
            input_modal_text = "#${base05}";
            input_modal_field_bg = "#${base02}";
            input_modal_field_text = "#${base05}";
            bkmk_modal_bg = "#${base01}";
            bkmk_modal_text = "#${base05}";
            bkmk_modal_label = "#${base0E}";
            bkmk_modal_field_bg = "#${base03}";
            bkmk_modal_field_text = "#${base05}";
          };
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
