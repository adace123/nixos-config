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
      hyprland.enable = true;
      monitor = {
        output = "HDMI-A-1";
        resolution = "2048x1152";
      };
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.sessionVariables = {
    TERMINAL = "wezterm";
    BROWSER = "firefox";
    EDITOR = "nvim";
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
