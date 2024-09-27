_: _final: prev: {
  kitty-scrollback = prev.vimUtils.buildVimPlugin {
    pname = "kitty-scrollback.nvim";
    version = "v5.0.0";

    src = prev.fetchFromGitHub {
      owner = "mikesmithgh";
      repo = "kitty-scrollback.nvim";
      rev = "v5.0.0";
      hash = "sha256-TV++v8aH0Vi9UZEdTT+rUpu6HKAfhu04EwAgGbfk614=";
    };

    meta = with prev.lib; {
      description = "😽 Open your Kitty scrollback buffer with Neovim. Ameowzing!";
      homepage = "https://github.com/mikesmithgh/kitty-scrollback.nvim";
      platforms = platforms.all;
    };
  };
}
