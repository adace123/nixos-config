{pkgs, ...}: {
  fonts.packages = with pkgs; [
    material-symbols
    roboto
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "GeistMono"];})
    font-awesome
    fira-code-symbols
    source-code-pro
  ];
}
