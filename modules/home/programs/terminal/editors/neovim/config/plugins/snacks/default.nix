{ pkgs, ... }:
let
  snacks-nvim = pkgs.vimPlugins.snacks-nvim.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "snacks.nvim";
      rev = "4f8b9ebf717b8acf41be02b0bd5a6d75f6038ea7";
      hash = "sha256-ZKCAWVoJCU+AS1A+1hyf27jVs9jKymSUwXN5/K3bRek=";
    };
    doCheck = false;
    doInstallCheck = false;
  };
in
{
  programs.nixvim.plugins.snacks = {
    enable = true;
    package = snacks-nvim;
    settings = {
      bufdelete.enable = true;
      bigfile.enable = true;
      explorer.enable = true;
      indent.enable = true;
      gitbrowse.enable = true;
      lazygit.enable = true;
      picker = {
        enable = true;
        win.input.keys.__raw = ''
          {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } }
          }
        '';
        # telescope layout
        layouts.default.__raw = ''
          {
            reverse = true,
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0.8,
              height = 0.9,
              border = "none",
              {
                box = "vertical",
                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.45,
                border = "rounded",
                title_pos = "center",
              },
            },
          }
        '';
      };
      rename.enable = true;
      toggle.enable = true;
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>fC";
      action.__raw = "Snacks.picker.colorschemes";
      options.desc = "Colorscheme";
    }
    {
      key = "<leader>fw";
      action.__raw = "Snacks.picker.grep";
      options.desc = "Live grep";
    }
    {
      key = "<leader>w";
      action.__raw = "Snacks.picker.grep";
      options.desc = "Live grep";
    }
    {
      key = "f";
      action.__raw = ''
        function () 
          Snacks.picker.grep({ search = vim.fn.expand("<cword>") })
        end
      '';
      mode = [ "v" ];
      options.desc = "Live grep";
    }
    {
      key = "<leader>fy";
      action.__raw = "Snacks.picker.cliphist";
      options.desc = "Clipboard history";
    }
    # {
    #  key = "<leader>ft";
    #  action.__raw = "Snacks.picker.todo_comments";
    #  options.desc = "Todos";
    # }
    {
      key = "<C-b>";
      action.__raw = "Snacks.picker.buffers";
      options.desc = "Buffers";
    }
    {
      key = "<leader>.";
      action.__raw = "Snacks.picker.resume";
      options.desc = "Repeat last query";
    }
    {
      key = "<leader>fz";
      action.__raw = "Snacks.picker.zoxide";
      options.desc = "Zoxide search";
    }
    {
      key = "<leader>ff";
      action.__raw = "Snacks.picker.files";
      options.desc = "Files";
    }
    {
      key = "<leader>fd";
      action.__raw = "Snacks.picker.diagnostics";
      options.desc = "LSP diagnostics";
    }
    {
      key = "<leader>fk";
      action.__raw = "Snacks.picker.keymaps";
      options.desc = "Keymaps";
    }
    {
      key = "<leader>fj";
      action.__raw = "Snacks.picker.jumps";
      options.desc = "Jumplist";
    }
    {
      key = "<leader>fm";
      action.__raw = "Snacks.picker.marks";
      options.desc = "Marks";
    }
    {
      key = "<leader>fo";
      action.__raw = "Snacks.picker.recent";
      options.desc = "Recent files";
    }
    {
      key = "<leader>fW";
      action.__raw = "Snacks.picker.grep_word";
      options.desc = "Grep word";
    }
    {
      key = "<leader>fp";
      action.__raw = "Snacks.picker.projects";
      options.desc = "Projects";
    }
    {
      key = "gr";
      action.__raw = "Snacks.picker.lsp_references";
      options.desc = "LSP references";
    }
    {
      key = "<leader>cs";
      action.__raw = "Snacks.picker.lsp_symbols";
      options.desc = "LSP symbols";
    }
    {
      key = "gd";
      action.__raw = "Snacks.picker.lsp_definitions";
      options.desc = "Goto definition";
    }
  ];
}
