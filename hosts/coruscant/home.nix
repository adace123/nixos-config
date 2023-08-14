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
      notifications.enable = true;
      media.enable = true;
      monitor = {
        output = "HDMI-A-1";
        resolution = "2048x1080";
      };
      terminal.alacritty = {
        enable = true;
      };
      browsers = {
        firefox.enable = true;
        qutebrowser.enable = true;
        amfora.enable = true;
      };
      pdf.enable = true;
      rofi.enable = true;
      social.discord.enable = true;
    };
    shell = {
      nushell.enable = true;
      starship.enable = true;
    };
    editors = {
      helix.enable = true;
      neovim.enable = true;
    };
    feeds = {
      enable = true;
      auto-refresh = true;
    };
    dev = {
      elixir.enable = true;
      git = {
        enable = true;
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhNNJWrql+UrZHP7KUw0cfnF7XqhIAVQ6S/JF8ecbPV";
      };
      go.enable = true;
      kubernetes.enable = true;
      python.enable = true;
      rust.enable = true;
      zig.enable = true;
    };
    ssh.enable = true;
    file-explorer.enable = true;
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
