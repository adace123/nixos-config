{pkgs, ...}: {
  imports = [./nix.nix ./users.nix ./fonts.nix];

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "22.05";

  networking = {
    useDHCP = false;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    bottom
    curl
    eza
    fzf
    git
    jq
    just
    kmon
    lsof
    nushell
    openssl
    pkg-config
    ripgrep
    rsync
    sops
    sysz
    tldr
    vim
    unzip
    yq
    tailspin
  ];
}
