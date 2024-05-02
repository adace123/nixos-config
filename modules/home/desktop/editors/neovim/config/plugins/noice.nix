{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      cmdline.view = "cmdline";
      lsp = {
        signature.enabled = true;
        progress.enabled = false;
        signature.view = "virtualtext";
        hover.view = "virtualtext";
        documentation.view = "virtualtext";
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
}
