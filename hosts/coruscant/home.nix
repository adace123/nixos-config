{
  pkgs,
  config,
  osConfig,
  inputs,
  ...
}: {
  modules = {
    desktop = {
      wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/scifi-background.jpg";
      idle.enable = true;
      waybar.enable = true;
      hyprland.enable = true;
      notifications.enable = true;
      media.enable = true;
      monitor = {
        output = "DP-1";
        resolution = "3440x1440";
      };
      terminal = {
        alacritty.enable = true;
        wezterm.enable = true;
        zellij.enable = true;
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
      vscode.enable = true;
    };
    feeds = {
      enable = true;
      auto-refresh = true;
    };
    dev = {
      elixir.enable = true;
      git.enable = true;
      go.enable = true;
      kubernetes.enable = true;
      python.enable = true;
      rust.enable = true;
      typescript.enable = true;
      zig.enable = true;
    };
    ssh.enable = true;
    file-explorer.enable = true;
  };

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.sessionVariables = {
    TERMINAL = "alacritty";
    BROWSER = "firefox";
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.ssh.matchBlocks."proxmox.homelab" = {
    hostname = "proxmox.homelab";
    user = "root";
    identityFile = [osConfig.sops.secrets.proxmox-private-key.path];
  };
}
