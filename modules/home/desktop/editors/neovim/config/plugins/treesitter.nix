{pkgs, ...}: let
  nu-grammar = pkgs.tree-sitter.buildGrammar {
    language = "nu";
    version = "0.0.0+rev=358c4f5";
    src = pkgs.fetchFromGitHub {
      owner = "nushell";
      repo = "tree-sitter-nu";
      rev = "2d0dd587dbfc3363d2af4e4141833e718647a67e";
      hash = "sha256-A0Lpsx0VFRYUWetgX3Bn5osCsLQrZzg90unGg9kTnVg=";
    };
  };
in {
  programs.nixvim = {
    filetype.extension = {
      nu = "nu";
      tf = "hcl";
      tfvars = "hcl";
    };
    plugins = {
      ts-autotag.enable = true;
      rainbow-delimiters.enable = true;
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = true;
        indent = true;
        incrementalSelection = {
          enable = true;
          keymaps = {
            initSelection = "<CR>";
            nodeIncremental = "<CR>";
            scopeIncremental = "<S-CR>";
            nodeDecremental = "<BS>";
          };
        };
        grammarPackages = with pkgs;
          vimPlugins.nvim-treesitter.passthru.allGrammars
          ++ [vimPlugins.nvim-treesitter.grammarPlugins.kdl]
          ++ [nu-grammar];
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

    extraFiles = {
      "/queries/nu/highlights.scm" = builtins.readFile "${nu-grammar}/queries/nu/highlights.scm";
      "/queries/nu/injections.scm" = builtins.readFile "${nu-grammar}/queries/nu/injections.scm";
    };

    extraConfigLua = ''
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.nu = {
        filetype = "nu",
      }
    '';
  };
}
