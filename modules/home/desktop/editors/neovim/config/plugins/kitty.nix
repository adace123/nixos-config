{pkgs, ...}: let
in {
  programs.nixvim = {
    extraPlugins = with pkgs; [vimPlugins.vim-kitty-navigator kittyScrollback];
    extraConfigLua = ''
      require("kitty-scrollback").setup()
    '';
  };

  xdg.configFile.vimKittyNavigatorPassKeys = {
    source = "${pkgs.vimPlugins.vim-kitty-navigator}/pass_keys.py";
    target = "kitty/pass_keys.py";
  };

  xdg.configFile.vimKittyNavigatorLayout = {
    source = "${pkgs.vimPlugins.vim-kitty-navigator}/get_layout.py";
    target = "kitty/get_layout.py";
  };
}
