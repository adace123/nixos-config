{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs; [
      bookmarks-nvim
    ];
    extraConfigLua = ''
      require("bookmarks").setup()
    '';
    keymaps = [
      {
        key = "<leader>fb";
        action = ":BookmarksGoto<CR>";
        options.desc = "Bookmarks";
      }
      {
        key = "<leader>ba";
        action = ":BookmarksMark<CR>";
        options.desc = "Add bookmark";
      }
      {
        key = "<leader>bd";
        action = ":BookmarksDesc<CR>";
        options.desc = "Add bookmark with description";
      }
      {
        key = "<leader>bi";
        action = ":BookmarksInfo<CR>";
        options.desc = "Bookmark info";
      }
    ];
  };
}
