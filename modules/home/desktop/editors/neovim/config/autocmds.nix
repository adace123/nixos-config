{
  programs.nixvim = {
    autoCmd = [
      {
        event = "TextYankPost";
        command = ''lua vim.highlight.on_yank { higroup = "Visual", timeout = 200 }'';
      }
      {
        event = "VimEnter";
        command = ''lua require("persistence").load({ last = true })'';
      }
    ];
  };
}
