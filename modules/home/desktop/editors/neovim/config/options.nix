{
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };

    options = {
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
      termguicolors = true;
      scrolloff = 8;
      swapfile = false;
      hlsearch = false;
      incsearch = true;

      shiftwidth = 2;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      smartindent = true;

      cursorline = true;
      number = true;
      relativenumber = true;
      numberwidth = 2;
      ruler = false;

      splitbelow = true;
      splitright = true;
      undofile = true;
      undolevels = 10000;

      signcolumn = "yes";
      cmdheight = 0;
      cot = ["menu" "menuone" "noselect"];
      colorcolumn = "120";

      updatetime = 100;
      timeout = true;
      timeoutlen = 250;

      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      clipboard = "unnamedplus";
    };
  };
}
