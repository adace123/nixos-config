{
  pkgs,
  inputs,
  ...
}:
with inputs; {
  environment.systemPackages = with pkgs; [
    bat
    bottom
    curl
    dnsutils
    duf
    du-dust
    exa
    fd
    fzf
    git
    jq
    just
    kmon
    nushell
    openssl
    pciutils
    ripgrep
    rsync
    sops
    unzip
    vim
    xh
  ];

  environment.shellAliases = with pkgs; {
    cat = "bat";
    ll = "exa -l";
    htop = "bottom --fahrenheit";
    grep = "rg";
  };
}
