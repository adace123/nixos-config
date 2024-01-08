{
  pkgs,
  inputs,
}: let
  mkPackage = path: pkgs.callPackage path {inherit pkgs inputs;};
in {
  firefox-theme-catppuccin-mocha = mkPackage ./firefox-themes/catppuccin.nix;
  # iso = inputs.nixos-generators.nixosGenerate {
  #   system = "x86_64-linux";
  #   modules = [../modules/nixos/installer];
  #   format = "install-iso";
  # };
}
