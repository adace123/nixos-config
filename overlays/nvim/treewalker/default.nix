_: _final: prev: {
  treewalker-nvim = prev.vimUtils.buildVimPlugin {
    pname = "treewalker-nvim";
    version = "v2.0.1";

    src = prev.fetchFromGitHub {
      owner = "aaronik";
      repo = "treewalker.nvim";
      rev = "efc57a4c3d91920fd03dbd602dfdf936de50e172";
      hash = "sha256-x+zsfgRkIT5MAYBmuTk6xX39UzDML6DVn0y67lyKCfc=";
    };
  };
}
