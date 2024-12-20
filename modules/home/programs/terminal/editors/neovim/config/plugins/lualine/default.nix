{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        globalstatus = true;
        disabledFiletypes.statusline = [
          "alpha"
          "neo-tree"
        ];
        extensions = [ "neo-tree" ];
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diagnostics"
            "diff"
          ];
          lualine_c = [ "filename" ];
          lualine_x = [
            {
              icon = "";
              __unkeyed-1.__raw = ''
                function()
                    local msg = ""
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end
              '';
            }
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };
  };
}
