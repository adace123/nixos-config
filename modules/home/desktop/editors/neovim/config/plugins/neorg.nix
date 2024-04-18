{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    autoCmd = [
      {
        event = "FileType";
        pattern = "norg";
        command = "setlocal conceallevel=1";
      }
      {
        event = "BufWritePre";
        pattern = "*.norg";
        command = "normal gg=G``zz";
      }
    ];

    plugins.treesitter.grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [norg];
    plugins.neorg = let
      nixpkgs-stable = import inputs.nixpkgs-stable {inherit (pkgs) system;};
    in {
      enable = true;
      package = nixpkgs-stable.vimPlugins.neorg;
      lazyLoading = true;
      modules = {
        "core.defaults".__empty = null;
        "core.keybinds".config.hook.__raw = ''
          function(keybinds)
            keybinds.unmap('norg', 'n', '<C-s>')

            keybinds.map(
              'norg',
              'n',
              '<leader>c',
              ':Neorg toggle-concealer<CR>',
              {silent=true}
            )
          end
        '';

        "core.dirman".config = {
          workspaces = {
            work = "~/Notes/work";
            personal = "~/Notes/personal";
          };
          default_workspace = "personal";
        };

        "core.concealer".__empty = null;
        "core.completion".config.engine = "nvim-cmp";
        "core.export".__empty = null;
      };
    };
  };
}
