{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    bottom
    curl
    exa
    fd
    fzf
    git
    jq
    kmon
    lsof
    nushell
    openssl
    ripgrep
    sops
    sysz
    tldr
    vim
    unzip
    yq
  ];
}
