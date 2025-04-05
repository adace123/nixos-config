{ pkgs, ... }:
let
  zellij-nav = pkgs.vimUtils.buildVimPlugin {
    name = "zellij-nav";
    src = builtins.fetchGit {
      url = "https://git.sr.ht/~swaits/zellij-nav.nvim";
      ref = "main";
      rev = "1d6657d8b8e1f6bbb275a48bc96092b248b8f522";
    };
  };

in
{
  programs.nixvim = {
    extraPlugins = [
      zellij-nav
    ];
    extraPackages = [ pkgs.zellij ];
    extraConfigLua = ''
      require('zellij-nav').setup()
    '';
    keymaps = [
      {
        mode = "n";
        key = "<c-h>";
        action = "<cmd>ZellijNavigateLeftTab<cr>";
        options.desc = "move focus to the left window";
      }
      {
        mode = "n";
        key = "<c-l>";
        action = "<cmd>ZellijNavigateRightTab<cr>";
        options.desc = "move focus to the right window";
      }
      {
        mode = "n";
        key = "<c-j>";
        action = "<cmd>ZellijNavigateDown<cr>";
        options.desc = "move focus to the lower window";
      }
      {
        mode = "n";
        key = "<c-k>";
        action = "<cmd>ZellijNavigateUp<cr>";
        options.desc = "move focus to the upper window";
      }
    ];
  };
}
