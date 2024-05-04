{
  inputs,
  pkgs,
  ...
}: {
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  home.packages = [pkgs.mkcert];
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
      neofetch.enable = true;
    };
    desktop = {
      terminal = {
        wezterm.enable = true;
        zellij.enable = true;
      };
    };
    file-explorer.enable = true;
  };
}
