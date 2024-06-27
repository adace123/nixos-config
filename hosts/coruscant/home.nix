{config, ...}: {
  modules = {
    desktop = {
      wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/minimal-space.png";
      hyprland = {
        enable = true;
        addons.enable = true;
      };
      media.enable = true;
      monitor = {
        output = "DP-2";
        resolution = "2560x1440";
      };
      terminal = {
        alacritty.enable = true;
        wezterm.enable = true;
        zellij.enable = true;
      };
      browsers = {
        firefox = {
          enable = true;
          isDefaultBrowser = true;
        };
        qutebrowser.enable = true;
        amfora.enable = true;
      };
      pdf.enable = true;
      social.discord.enable = true;
    };
    shell = {
      nushell.enable = true;
      starship.enable = true;
      neofetch.enable = true;
    };
    editors = {
      helix.enable = true;
      vscode.enable = true;
      neovim.enable = true;
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

  home.sessionVariables = {
    TERMINAL = "alacritty";
    BROWSER = "firefox";
  };

  sops.secrets = {
    proxmox-private-key.path = "/home/${config.home.username}/.ssh/proxmox-private-key";
  };

  programs.ssh.matchBlocks."proxmox.homelab" = {
    hostname = "proxmox.homelab";
    user = "root";
    identityFile = [config.sops.secrets.proxmox-private-key.path];
  };
}
