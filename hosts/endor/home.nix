{inputs, ...}: {
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  modules = {
    dev = {
      python.enable = true;
      kubernetes.enable = true;
    };
    editors.neovim.enable = true;
    shell = {
      nushell.enable = true;
      starship.enable = true;
    };
  };
}
