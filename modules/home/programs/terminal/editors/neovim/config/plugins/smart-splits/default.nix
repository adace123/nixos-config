_: {
  programs.nixvim = {
    plugins.smart-splits.enable = true;
    extraConfigLua = "local splits = require('smart-splits')";
    keymaps = [
      {
        mode = "n";
        key = "<C-h>";
        action.__raw = "function() require('smart-splits').move_cursor_left() end";
        options.desc = "Move focus to the left window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action.__raw = "function() require('smart-splits').move_cursor_right() end";
        options.desc = "Move focus to the right window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action.__raw = "function() require('smart-splits').move_cursor_down() end";
        options.desc = "Move focus to the lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action.__raw = "function() require('smart-splits').move_cursor_up() end";
        options.desc = "Move focus to the upper window";
      }
    ];
  };
}
