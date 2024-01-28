{pkgs, ...}: {
  imports = [./nix.nix ./users.nix];

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
    fd
    fzf
    git
    hyperfine
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

  fonts.packages = with pkgs; [
    material-symbols
    roboto
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "GeistMono"];})
    font-awesome
    fira-code-symbols
    source-code-pro
  ];
}
