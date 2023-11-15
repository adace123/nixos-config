{
  pkgs,
  inputs,
  ...
}: let
  nixpkgs = import inputs.nixpkgs-latest {inherit (pkgs) system;};
in {
  fonts.packages = with pkgs; [
    material-symbols
    roboto
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    font-awesome
    nixpkgs.monaspace
    fira-code-symbols
    source-code-pro
  ];
}
