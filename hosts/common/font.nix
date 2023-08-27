{pkgs, ...}: {
  fonts.packages = with pkgs; [
    material-symbols
    roboto
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    font-awesome
  ];
}
