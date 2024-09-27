{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.aerial-nvim ];
    extraConfigLua = ''
      require("aerial").setup()
    '';
    keymaps = [
      {
        key = "<leader>n";
        action = ":AerialNavToggle<CR>";
        options.desc = "Aerial Nav";
      }
    ];
  };
}
