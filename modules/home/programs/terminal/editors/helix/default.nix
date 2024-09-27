{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.editors.helix;
in
with lib;
{
  options.adace.programs.terminal.editors.helix.enable = mkEnableOption "Helix editor";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pkgs.nodePackages.typescript-language-server ];
    programs.helix = {
      enable = true;
      languages = {
        language-server.nixd.command = "${pkgs.nixd}/bin/nixd";
        language = [
          {
            name = "nix";
            formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
            language-servers = [ "nixd" ];
            auto-format = true;
          }
          {
            name = "python";
            formatter.command = "${pkgs.ruff}/bin/ruff format -";
            language-servers = [ "pyright" ];
            auto-format = true;
          }
        ];
      };
      settings = {
        editor = {
          auto-completion = true;
          bufferline = "always";
          color-modes = true;
          soft-wrap.enable = true;
          indent-guides = {
            render = true;
            rainbow-option = "dim";
          };
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
            auto-signature-help = true;
            snippets = true;
          };
          statusline = {
            left = [
              "mode"
              "spinner"
            ];
            center = [
              "file-name"
              "version-control"
            ];
            right = [
              "total-line-numbers"
              "diagnostics"
              "position"
            ];
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "block";
          };
        };
        keys = {
          insert = {
            C-s = ":w";
            j = {
              k = "normal_mode";
            };
            k = {
              j = "normal_mode";
            };
          };
          select = {
            # Muscle memory
            "{" = [
              "extend_to_line_bounds"
              "goto_prev_paragraph"
            ];
            "}" = [
              "extend_to_line_bounds"
              "goto_next_paragraph"
            ];
            "0" = "goto_line_start";
            "$" = "goto_line_end";
            "^" = "goto_first_nonwhitespace";
            G = "goto_file_end";
            D = [
              "extend_to_line_bounds"
              "delete_selection"
              "normal_mode"
            ];
            C = [
              "goto_line_start"
              "extend_to_line_bounds"
              "change_selection"
            ];
            "%" = "match_brackets";
            S = "surround_add";
            u = [
              "switch_to_lowercase"
              "collapse_selection"
              "normal_mode"
            ];
            U = [
              "switch_to_uppercase"
              "collapse_selection"
              "normal_mode"
            ];

            # Visual-mode specific muscle memory
            i = "select_textobject_inner";
            a = "select_textobject_around";

            # Some extra binds to allow us to insert/append in select mode because it's nice with multiple cursors
            tab = [
              "insert_mode"
              "collapse_selection"
            ];
            C-a = [
              "append_mode"
              "collapse_selection"
            ];

            # Make selecting lines in visual mode behave sensibly
            k = [
              "extend_line_up"
              "extend_to_line_bounds"
            ];
            j = [
              "extend_line_down"
              "extend_to_line_bounds"
            ];

            # Clipboards over registers ye ye
            d = [
              "yank_main_selection_to_clipboard"
              "delete_selection"
            ];
            x = [
              "yank_main_selection_to_clipboard"
              "delete_selection"
            ];
            y = [
              "yank_main_selection_to_clipboard"
              "normal_mode"
              "flip_selections"
              "collapse_selection"
            ];
            Y = [
              "extend_to_line_bounds"
              "yank_main_selection_to_clipboard"
              "goto_line_start"
              "collapse_selection"
              "normal_mode"
            ];
            p = "replace_selections_with_clipboard"; # No life without this
            P = "paste_clipboard_before";

            # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
            esc = [
              "collapse_selection"
              "keep_primary_selection"
              "normal_mode"
            ];
          };
          normal = {
            space.space = "file_picker";
            C-h = "select_prev_sibling";
            C-j = "shrink_selection";
            C-k = "expand_selection";
            C-l = "select_next_sibling";

            # Muscle memory
            "{" = [
              "goto_prev_paragraph"
              "collapse_selection"
            ];
            "}" = [
              "goto_next_paragraph"
              "collapse_selection"
            ];
            "0" = "goto_line_start";
            "$" = "goto_line_end";
            "^" = "goto_first_nonwhitespace";
            G = "goto_file_end";
            "%" = "match_brackets";
            V = [
              "select_mode"
              "extend_to_line_bounds"
            ];
            C = [
              "extend_to_line_end"
              "yank_main_selection_to_clipboard"
              "delete_selection"
              "insert_mode"
            ];
            D = [
              "extend_to_line_end"
              "yank_main_selection_to_clipboard"
              "delete_selection"
            ];
            S = "surround_add";

            # Clipboards over registers ye ye
            x = "delete_selection";
            p = [
              "paste_clipboard_after"
              "collapse_selection"
            ];
            P = [
              "paste_clipboard_before"
              "collapse_selection"
            ];
            Y = [
              "extend_to_line_end"
              "yank_main_selection_to_clipboard"
              "collapse_selection"
            ];

            # Uncanny valley stuff this makes w and b behave as they do Vim
            w = [
              "move_next_word_start"
              "move_char_right"
              "collapse_selection"
            ];
            W = [
              "move_next_long_word_start"
              "move_char_right"
              "collapse_selection"
            ];
            e = [
              "move_next_word_end"
              "collapse_selection"
            ];
            E = [
              "move_next_long_word_end"
              "collapse_selection"
            ];
            b = [
              "move_prev_word_start"
              "collapse_selection"
            ];
            B = [
              "move_prev_long_word_start"
              "collapse_selection"
            ];

            # Undoing the 'd' + motion commands restores the selection which is annoying
            u = [
              "undo"
              "collapse_selection"
            ];

            # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
            esc = [
              "collapse_selection"
              "keep_primary_selection"
            ];

            # Search for word under cursor
            "*" = [
              "move_char_right"
              "move_prev_word_start"
              "move_next_word_end"
              "search_selection"
              "search_next"
            ];
            "#" = [
              "move_char_right"
              "move_prev_word_start"
              "move_next_word_end"
              "search_selection"
              "search_prev"
            ];

            d = {
              d = [
                "extend_to_line_bounds"
                "yank_main_selection_to_clipboard"
                "delete_selection"
              ];
              t = [ "extend_till_char" ];
              s = [ "surround_delete" ];
              i = [ "select_textobject_inner" ];
              a = [ "select_textobject_around" ];
              j = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_below"
                "yank_main_selection_to_clipboard"
                "delete_selection"
                "normal_mode"
              ];
              down = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_below"
                "yank_main_selection_to_clipboard"
                "delete_selection"
                "normal_mode"
              ];
              k = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_above"
                "yank_main_selection_to_clipboard"
                "delete_selection"
                "normal_mode"
              ];
              up = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_above"
                "yank_main_selection_to_clipboard"
                "delete_selection"
                "normal_mode"
              ];
              G = [
                "select_mode"
                "extend_to_line_bounds"
                "goto_last_line"
                "extend_to_line_bounds"
                "yank_main_selection_to_clipboard"
                "delete_selection"
                "normal_mode"
              ];
              w = [
                "move_next_word_start"
                "yank_main_selection_to_clipboard"
                "delete_selection"
              ];
              W = [
                "move_next_long_word_start"
                "yank_main_selection_to_clipboard"
                "delete_selection"
              ];
              g = {
                g = [
                  "select_mode"
                  "extend_to_line_bounds"
                  "goto_file_start"
                  "extend_to_line_bounds"
                  "yank_main_selection_to_clipboard"
                  "delete_selection"
                  "normal_mode"
                ];
              };
            };
            y = {
              y = [
                "extend_to_line_bounds"
                "yank_main_selection_to_clipboard"
                "normal_mode"
                "collapse_selection"
              ];
              j = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_below"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
              down = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_below"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
              k = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_above"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
              up = [
                "select_mode"
                "extend_to_line_bounds"
                "extend_line_above"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
              G = [
                "select_mode"
                "extend_to_line_bounds"
                "goto_last_line"
                "extend_to_line_bounds"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
              w = [
                "move_next_word_start"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
              W = [
                "move_next_long_word_start"
                "yank_main_selection_to_clipboard"
                "collapse_selection"
                "normal_mode"
              ];
              g = {
                g = [
                  "select_mode"
                  "extend_to_line_bounds"
                  "goto_file_start"
                  "extend_to_line_bounds"
                  "yank_main_selection_to_clipboard"
                  "collapse_selection"
                  "normal_mode"
                ];
              };
            };
          };
        };
      };
    };
  };
}
