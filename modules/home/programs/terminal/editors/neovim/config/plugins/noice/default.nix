{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
        cmdline.view = "cmdline";
        lsp = {
          signature.enabled = true;
          progress.enabled = false;
          signature.view = "virtualtext";
          hover.view = "virtualtext";
          documentation.view = "virtualtext";
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
        };
        routes = [
          {
            view = "cmdline";
            filter.any = [
              {
                event = "msg_show";
                kind = "confirm_sub";
              }
            ];
          }
          {
            view = "notify";
            filter.any = [
              {
                event = "msg_showmode";
              }
            ];
          }
        ];
      };
    };
  };
}
