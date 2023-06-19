{
  pkgs,
  inputs,
}: let
  mkPackage = path: pkgs.callPackage path {inherit pkgs inputs;};
in {
  firefox-theme-catppuccin-mocha = mkPackage ./firefox-themes/catppuccin.nix;
  systemd-toggle = mkPackage ./scripts/systemd-toggle.nix;
}
