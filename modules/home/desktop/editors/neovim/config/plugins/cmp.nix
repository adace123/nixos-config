{
  programs.nixvim = {
    opts.completeopt = "menu,menuone,noselect";
    plugins = {
      luasnip = {
        enable = true;
        fromVscode = [{}];
      };
      friendly-snippets.enable = true;
      lspkind = {
        enable = true;
        cmp.enable = true;
      };

      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      cmp-treesitter.enable = true;
      cmp-cmdline.enable = true;
      cmp-cmdline-history.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      crates-nvim.enable = true;

      cmp = {
        enable = true;
        settings = {
          experimental.ghost_text = true;
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          sources = [
            {name = "nvim_lsp";}
            {name = "nvim_lsp_signature_help";}
            {name = "nvim_lua";}
            {name = "luasnip";}
            {name = "treesitter";}
            {name = "buffer";}
            {name = "path";}
            {name = "crates";}
          ];
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(4)";
            "<C-u>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          window = {
            completion = {};
            documentation = {};
          };
        };
      };
    };

    extraConfigLua = ''
      local cmp = require("cmp")
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

        -- Use buffer source for `/`
      cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    '';
  };
}
