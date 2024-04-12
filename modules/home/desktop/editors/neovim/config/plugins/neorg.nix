{
  pkgs,
  inputs,
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

    plugins.neorg = let
      nixpkgs-stable = import inputs.nixpkgs-stable {inherit (pkgs) system;};
    in {
      enable = true;
      package = nixpkgs-stable.vimPlugins.neorg;
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

        "core.dirman".config.workspaces = {
          notes = "~/notes";
        };

        "core.concealer".__empty = null;
        "core.completion".config.engine = "nvim-cmp";
      };
    };
    extraPlugins = [pkgs.vimPlugins.headlines-nvim];
    extraConfigLua = "require('headlines').setup()";
  };
  home.packages = [pkgs.lua54Packages.lua-utils-nvim];
}
