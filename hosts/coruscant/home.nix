{
  pkgs,
  inputs,
  ...
}: {
  modules = {
    desktop = {
      wallpaper = ../../assets/blue_circuit.png;
      lock.enable = true;
      idle.enable = true;
      waybar.enable = true;
      hyprland.enable = true;
      monitor = {
        output = "HDMI-A-1";
        resolution = "2048x1080";
      };
      terminal.alacritty = {
        enable = true;
        themeOverride = "shades-of-purple";
      };
      browsers.firefox.enable = true;
    };
    shell = {
      nushell.enable = true;
      starship.enable = true;
    };
    editors.neovim.enable = true;
    dev = {
      python.enable = true;
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.sessionVariables.TERMINAL = "alacritty";
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
