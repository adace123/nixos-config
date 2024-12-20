_: _final: prev: {
  bookmarks-nvim = prev.vimUtils.buildVimPlugin {
    pname = "bookmarks.nvim";
    version = "v2.0.1";

    src = prev.fetchFromGitHub {
      owner = "LintaoAmons";
      repo = "bookmarks.nvim";
      rev = "v2.0.1";
      hash = "sha256-TNUvZhniHYmzXcoWYaReKN3NHxxTbgl8yrlnY1DD/vs=";
    };
  };
}
