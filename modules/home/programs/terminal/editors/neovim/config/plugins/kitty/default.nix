{ pkgs, ... }:
{
  programs.nixvim = {
    # plugins.smart-splits.enable = true;
    extraPlugins = with pkgs; [
      kitty-scrollback
    ];
    extraConfigLua = ''
      require("kitty-scrollback").setup()
    '';
  };
}
