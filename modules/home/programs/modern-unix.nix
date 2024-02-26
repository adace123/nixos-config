{pkgs, ...}: {
  home.packages = with pkgs; [
    doggo
    delta
    duf
    dysk
    eva
    fd
    gum
    hyperfine
    ouch
    sd
  ];
}
