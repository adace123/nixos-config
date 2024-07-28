{pkgs, ...}: {
  home.packages = [pkgs.mkcert];
  catppuccin.pointerCursor.enable = false;
  modules = {
    dev = {
      python.enable = true;
      rust.enable = true;
      go.enable = true;
      kubernetes.enable = true;
      typescript.enable = true;
    };
    editors.neovim.enable = true;
    shell = {
      nushell.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
    };
    desktop = {
      terminal = {
        wezterm.enable = true;
        zellij.enable = true;
        kitty.enable = true;
      };
    };
    file-explorer.enable = true;
  };
}
