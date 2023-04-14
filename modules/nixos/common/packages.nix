{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    bottom
    dnsutils
    duf
    du-dust
    exa
    fd
    fzf
    git
    jq
    kubectl
    nushell
    openssl
    ripgrep
    rsync
    unzip
    vim
    xh
  ];

  environment.shellAliases = with pkgs; {
    cat = "${bat}";
    ll = "${exa} -l";
    htop = "${bottom} --fahrenheit";
    grep = "${ripgrep}";
    k = "${kubectl}";
  };
}
