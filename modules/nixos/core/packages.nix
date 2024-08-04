{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    curl
    eza
    fzf
    git
    jq
    just
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
