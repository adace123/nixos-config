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
    just
    kmon
    lsof
    nushell
    openssl
    python311Packages.invoke
    ripgrep
    sops
    sysz
    tldr
    vim
    unzip
    yq
  ];
}
