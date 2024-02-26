{pkgs, ...}: {
  home.packages = with pkgs; [
    doggo
    delta
    duf
    dysk
    eva
    fd
    glow
    gum
    hyperfine
    ouch
    sd
  ];
}
