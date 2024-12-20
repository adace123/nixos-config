_: {
  programs.nixvim = {
    plugins.aerial = {
      enable = true;
    };
    keymaps = [
      {
        key = "<leader>n";
        action = ":AerialNavToggle<CR>";
        options.desc = "Aerial Nav";
      }
    ];
  };
}
