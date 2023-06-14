{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bat
    bottom
    curl
    exa
    fd
    fzf
    git
    kmon
    jq
    nushell
    openssl
    ripgrep
    sops
    sysz
    vim
    unzip
    yq
  ];
}
