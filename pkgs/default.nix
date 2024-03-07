{
  pkgs,
  inputs,
  ...
}: let
  mkPackage = path: pkgs.callPackage path {inherit pkgs inputs;};
in {
  tgpt = mkPackage ./tgpt.nix;
}
