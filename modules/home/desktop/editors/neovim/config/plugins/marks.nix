{pkgs, ...}: {
  programs.nixvim.plugins = {
    marks = {
      enable = true;
      package = pkgs.vimPlugins.marks-nvim.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "ValJed";
          repo = "marks.nvim";
          rev = "feat-telescope-support-for-listing-marks";
          hash = "sha256-WMLpYvoVKZCS5M+q0w26wYQ4GIIf1omjW+j9evRqvkE=";
        };
      });
    };
  };
}
