{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      ts-autotag.enable = true;
      rainbow-delimiters.enable = true;
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = true;
        languageRegister.nu = "nu";
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<CR>";
              node_incremental = "<CR>";
              scope_incremental = "<S-CR>";
              node_decremental = "<BS>";
            };
          };
        };
        grammarPackages =
          with pkgs;
          vimPlugins.nvim-treesitter.allGrammars
          ++ [
            vimPlugins.nvim-treesitter.grammarPlugins.kdl
          ];
      };
      treesitter-textobjects = {
        enable = true;
        lspInterop = {
          enable = true;
          border = "rounded";
        };
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "a=" = {
              query = "@assignment.outer";
              desc = "Select outer part of an assignment";
            };
            "i=" = {
              query = "@assignment.inner";
              desc = "Select outer part of an assignment";
            };
            "l=" = {
              query = "@assignment.lhs";
              desc = "Select the left hand side of a statement";
            };
            "r=" = {
              query = "@assignment.rhs";
              desc = "Select the right hand side of a statement";
            };
            "aa" = {
              query = "@parameter.outer";
              desc = "Select the outer part of the parameter";
            };
            "ia" = {
              query = "@parameter.inner";
              desc = "Select the inner part of the parameter";
            };
            "ai" = {
              query = "@conditional.outer";
              desc = "Select the outer part of the conditional";
            };
            "ii" = {
              query = "@conditional.inner";
              desc = "Select the inner part of the conditional";
            };
            "al" = {
              query = "@loop.outer";
              desc = "Select the outer part of the loop";
            };
            "il" = {
              query = "@loop.inner";
              desc = "Select the inner part of the loop";
            };
            "am" = {
              query = "@call.outer";
              desc = "Select the outer part of a function call";
            };
            "if" = {
              query = "@call.inner";
              desc = "Select the inner part of a function call";
            };
            "af" = {
              query = "@function.outer";
              desc = "Select the outer part of a function definition";
            };
            "im" = {
              query = "@function.inner";
              desc = "Select the inner part of a function definition";
            };
            "ic" = {
              query = "@class.inner";
              desc = "Select the inner part of a class";
            };
            "ac" = {
              query = "@class.outer";
              desc = "Select the outer part of a class";
            };
          };
        };
        move = {
          enable = true;
          setJumps = true;

          gotoNextStart = {
            "]f" = {
              query = "@function.outer";
              desc = "Next function start";
            };
            "]c" = {
              query = "@class.outer";
              desc = "Next class start";
            };
          };
          gotoNextEnd = {
            "]F" = {
              query = "@function.outer";
              desc = "Next function end";
            };
            "]C" = {
              query = "@class.outer";
              desc = "Next class end";
            };
          };
          gotoPreviousStart = {
            "[f" = {
              query = "@function.outer";
              desc = "Prev function start";
            };
            "[c" = {
              query = "@class.outer";
              desc = "Prev class start";
            };
          };
          gotoPreviousEnd = {
            "[F" = {
              query = "@function.outer";
              desc = "Prev function end";
            };
            "[C" = {
              query = "@class.outer";
              desc = "Prev class end";
            };
          };
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      vim-just
    ];
    # extraFiles = {
    #   "/queries/nu/highlights.scm".source = "${treesitter-nu-grammar}/queries/nu/highlights.scm";
    #   "/queries/nu/injections.scm".source = "${treesitter-nu-grammar}/queries/nu/injections.scm";
    #   "/queries/nu/indents.scm".source = "${treesitter-nu-grammar}/queries/nu/indents.scm";
    # };
  };
}
